import db from "../Database.js";
import UserModel from "../Models/User.model.js";
import ResponseAsnwer from "../Utils/index.js";
import Logger from "../Lib/Logger.js";
import jwt from "jsonwebtoken";
import { ACCESS_TOKEN_KEY, REFRESH_ACCESS_TOKEN_KEY } from "../Config/index.js";

export default class AuthController {
  async login(req, res) {
    try {
      await db.getInstance();
      const { email, password } = req.body;
      const user = await UserModel.findOne({ email });
      // validating credentials
      if (!user) {
        // create user
        // const newUser = new UserModel({
        //     username: email.split('@')[0],
        //     email,
        //     hashed_password: password,
        //     isVerified: true
        // });
        // await newUser.save();
        return res
          .status(200)
          .json(ResponseAsnwer("EMAIL_ERR", "Email isn't registered", []));
      }
      const isPasswordMatch = await user.isPasswordMatch(password);
      if (!isPasswordMatch) {
        return res
          .status(200)
          .json(ResponseAsnwer("PASSWORD_ERR", "Password is incorrect", []));
      }

      // Generating tokens
      const accessToken = jwt.sign({ email: user.email }, ACCESS_TOKEN_KEY, {
        expiresIn: "15m",
      });
      const refreshToken = jwt.sign(
        { email: user.email },
        REFRESH_ACCESS_TOKEN_KEY
      );

      // Saving refresh token
      user.refreshToken = refreshToken;
      await user.save();

      return res
        .status(200)
        .json(
          ResponseAsnwer("LOGIN_SUCCESS", "Login success", {
            accessToken,
            refreshToken,
            user: user.minimize(),
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
