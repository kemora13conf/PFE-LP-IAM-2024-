import db from "../Database.js";
import ParentModel from "../Models/Parent.model.js";
import ResponseAsnwer from "../Utils/index.js";
import jwt from "jsonwebtoken";
import { ACCESS_TOKEN_KEY, REFRESH_ACCESS_TOKEN_KEY } from "../Config/index.js";
import multer from "multer";
import path from "path";
import { __dirname } from "../Server.js";
import { log } from "console";
import Logger from "../Lib/Logger.js";

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, "../public/Parents-images"));
  },
  filename: function (req, file, cb) {
    let arrName = file.originalname.split(".");
    let extension = arrName[arrName.length - 1];
    let name = `${req.body.fullname}-${Date.now()}.${extension}`;
    req.body.image = name;
    cb(null, name);
  },
});

export default class AuthController {
  constructor() {
    this.upload = multer({ storage: storage });
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

  async register(req, res) {
    try {
      await db.getInstance();
      const parent = new ParentModel({
        nom: req.body.fullname,
        email: req.body.email,
        hashed_password: req.body.password,
        genre: req.body.gender,
        image: req.body.image,
      });
      await parent.save();
      return res
        .status(200)
        .json(ResponseAsnwer("SUCCESS", "Register success", []));
    } catch (err) {
      Logger.error(err.message);
      return res
        .status(200)
        .json(ResponseAsnwer("SERVER_ERR", err.message, []));
    }
  }

  async loginRequired(req, res, next) {}
}
