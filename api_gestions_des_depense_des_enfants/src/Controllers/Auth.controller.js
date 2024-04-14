import db from "../Database.js";
import ParentModel from "../Models/Parent.model.js";
import ResponseAsnwer from "../Utils/index.js";
import jwt from "jsonwebtoken";
import { ACCESS_TOKEN_KEY, REFRESH_ACCESS_TOKEN_KEY } from "../Config/index.js";

export default class AuthController {
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

      return res
        .status(200)
        .json(
          ResponseAsnwer("LOGIN_SUCCESS", "Login success", {
            accessToken,
            refreshToken,
            parent: parent.minimize(),
          })
        );
    } catch (err) {
      return res
        .status(500)
        .json(ResponseAsnwer("SERVER_ERR", err.message, []));
    }
  }

  async loginRequired(req, res, next){

  }
}
