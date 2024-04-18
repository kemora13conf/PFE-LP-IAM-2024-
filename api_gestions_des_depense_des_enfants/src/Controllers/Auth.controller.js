import db from "../Database.js";
import ParentModel from "../Models/Parent.model.js";
import ResponseAsnwer from "../Utils/index.js";
import jwt from "jsonwebtoken";
import { ACCESS_TOKEN_KEY, REFRESH_ACCESS_TOKEN_KEY } from "../Config/index.js";
import multer from "multer";
import path from "path";
import fs from "fs";
import { __dirname } from "../Server.js";
import Logger from "../Lib/Logger.js";
import EmailVerificationModel from "../Models/EmailVerification.model.js";
import Mail from "../Utils/Mail.js";

function getFilename(originalname) {
  let arrName = originalname.split(".");
  let extension = arrName[arrName.length - 1];
  let nameWithoutExtension = arrName.slice(0, arrName.length - 1).join(".");
  let saveAs = `${nameWithoutExtension}-${Date.now()}.${extension}`;
  return saveAs;
}
function sizeInMegaBytes(size) {
  // only two decimal places
  return (size / (1024 * 1024)).toFixed(3);
}
function saveFile(file) {
  let saveAs = getFilename(file.originalname);
  let imageBuffer = file.buffer;
  let size = file.size;
  let filePath = path.join(__dirname, "../public/Parents-images", saveAs);
  fs.writeFileSync(filePath, imageBuffer);

  Logger.info(`====== New File Saved ======`);
  Logger.info(`Path: ${filePath}`);
  Logger.info(`Size: ${sizeInMegaBytes(size)} MegaByte`); // in mega bytes
  Logger.info(`Name: ${saveAs}`);
  Logger.info(`============================`);

  return saveAs;
}

function generateTokenWithChar() {
  let token = "";
  let characters =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*?";
  let charactersLength = characters.length;
  for (let i = 0; i < 12; i++) {
    token += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return token;
}

export default class AuthController {
  constructor() {
    this.storage = multer.memoryStorage();
    this.upload = multer({ storage: this.storage });
  }
  async login(req, res) {
    try {
      await db.getInstance();
      const { email, password } = req.body;
      const parent = await ParentModel.findOne({ email });
      // validating credentials
      if (!parent) {
        return res
          .status(200)
          .json(ResponseAsnwer("EMAIL_ERR", "Email isn't registered", []));
      }
      const isPasswordMatch = await parent.isPasswordMatch(password);
      if (!isPasswordMatch) {
        return res
          .status(200)
          .json(ResponseAsnwer("PASSWORD_ERR", "Password is incorrect", []));
      }

      // Generating tokens
      const accessToken = jwt.sign({ email: parent.email }, ACCESS_TOKEN_KEY, {
        expiresIn: "15m",
      });
      const refreshToken = jwt.sign(
        { email: parent.email },
        REFRESH_ACCESS_TOKEN_KEY
      );

      // Saving refresh token
      parent.refreshToken = refreshToken;
      await parent.save();

      return res.status(200).json(
        ResponseAsnwer("SUCCESS", "Login success", {
          accessToken,
          refreshToken,
          parent: parent.minimize(),
        })
      );
    } catch (err) {
      return res
        .status(200)
        .json(ResponseAsnwer("SERVER_ERR", err.message, []));
    }
  }
  async refreshToken(req, res) {
    try {
      await db.getInstance();
      const { refreshToken } = req.body;
      const parent = await ParentModel.findOne({ refreshToken });
      if (!parent) {
        return res
          .status(200)
          .json(ResponseAsnwer("REFRESH_TOKEN", "Invalid refresh token", []));
      }

      // Generating new access token
      const accessToken = jwt.sign({ email: parent.email }, ACCESS_TOKEN_KEY, {
        expiresIn: "15m",
      });

      return res.status(200).json(
        ResponseAsnwer("REFRESH_SUCCESS", "Refresh success", {
          accessToken,
          parent: parent.minimize(),
        })
      );
    } catch (err) {
      return res
        .status(500)
        .json(ResponseAsnwer("SERVER_ERR", err.message, []));
    }
  }
  async validateToken(req, res) {
    try {
      const { token } = req.body;
      jwt.verify(token, ACCESS_TOKEN_KEY);
      return res
        .status(200)
        .json(ResponseAsnwer("TOKEN_VALID", "Token is valid", []));
    } catch (err) {
      return res
        .status(200)
        .json(ResponseAsnwer("TOKEN_INVALID", "Token is invalid", []));
    }
  }
  async checkEmail(req, res) {
    try {
      await db.getInstance();
      const { email } = req.body;
      const parent = await ParentModel.findOne({ email });
      if (parent) {
        return res
          .status(200)
          .json(ResponseAsnwer("EMAIL_EXISTS", "This email is taken!", []));
      }
      return res
        .status(200)
        .json(ResponseAsnwer("EMAIL_NOT_EXISTS", "Email doesn't exist", []));
    } catch (err) {
      return res
        .status(500)
        .json(ResponseAsnwer("SERVER_ERR", err.message, []));
    }
  }
  async sendVerificationEmail(req, res) {
    try {
      await db.getInstance();
      const { email, update_password } = req.body;
      if (update_password) {
        const parent = await ParentModel.findOne({ email });
        if (!parent) {
          return res
            .status(200)
            .json(
              ResponseAsnwer("EMAIL_NOT_EXISTS", "Email doesn't exist", [])
            );
        }
      }

      let EmailModel = await EmailVerificationModel.findOne({ email });
      if (!EmailModel) {
        EmailModel = new EmailVerificationModel({
          email,
          token: "empty",
          emailId: "empty",
          emailType: "register",
        });
        await EmailModel.save();
      }
      const token = generateTokenWithChar();
      const expiresAt = new Date(Date.now() + 60 * 60 * 1000);
      EmailModel.token = token;
      EmailModel.expiresAt = expiresAt;
      EmailModel.emailType = update_password ? "forgot-password" : "register";
      const Email = new Mail(token, email);
      const info = await Email.send();
      EmailModel.emailId = info.messageId;
      await EmailModel.save();
      return res
        .status(200)
        .json(ResponseAsnwer("EMAIL_SENT", "Email sent", []));
    } catch (err) {
      return res
        .status(500)
        .json(ResponseAsnwer("SERVER_ERR", err.message, []));
    }
  }
  async resetPassword(req, res) {
    try {
      await db.getInstance();
      const { token, password } = req.body;
      const EmailModel = await EmailVerificationModel.findOne({ token });
      if (!EmailModel) {
        return res
          .status(200)
          .json(ResponseAsnwer("TOKEN_INVALID", "Token is invalid", []));
      }
      const { expiresAt } = EmailModel;
      if (expiresAt < new Date()) {
        return res
          .status(200)
          .json(ResponseAsnwer("TOKEN_EXPIRED", "Token is expired", []));
      }
      const parent = await ParentModel.findOne({ email: EmailModel.email });
      parent.hashed_password = password;
      await parent.save();
      return res
        .status(200)
        .json(ResponseAsnwer("PASSWORD_CHANGED", "Password changed", []));
    } catch (err) {
      return res
        .status(500)
        .json(ResponseAsnwer("SERVER_ERR", err.message, []));
    }
  }
  async verifyEmail(req, res) {
    try {
      await db.getInstance();
      const token = req.body.token;
      const Email = req.body.email;
      const EmailModel = await EmailVerificationModel.findOne({
        token,
        email: Email,
      });
      if (!EmailModel) {
        return res
          .status(200)
          .json(ResponseAsnwer("TOKEN_INVALID", "Token is invalid", []));
      }
      const { expiresAt } = EmailModel;
      if (expiresAt < new Date()) {
        return res
          .status(200)
          .json(ResponseAsnwer("TOKEN_EXPIRED", "Token is expired", []));
      }
      EmailModel.isVerified = true;
      await EmailModel.save();
      return res
        .status(200)
        .json(ResponseAsnwer("TOKEN_VALID", "Token is valid", []));
    } catch (err) {
      return res
        .status(500)
        .json(ResponseAsnwer("SERVER_ERR", err.message, []));
    }
  }
  async register(req, res) {
    try {
      await db.getInstance();
      const emailVerified = await EmailModel.findOne({ email: req.body.email });
      const parent = new ParentModel({
        nom: req.body.fullname,
        email: req.body.email,
        hashed_password: req.body.password,
        genre: req.body.gender,
        image: getFilename(req.file.originalname),
        isVerified: emailVerified ? emailVerified.isVerified : false,
      });
      await parent.save();
      saveFile(req.file);
      return res
        .status(200)
        .json(ResponseAsnwer("SUCCESS", "Register success", []));
    } catch (err) {
      console.log(err);
      return res
        .status(200)
        .json(ResponseAsnwer("SERVER_ERR", err.message, []));
    }
  }
  static async loginRequired(req, res, next) {}
}
