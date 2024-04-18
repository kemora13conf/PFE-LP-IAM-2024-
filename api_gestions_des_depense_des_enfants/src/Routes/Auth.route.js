import AuthController from "../Controllers/Auth.controller.js";
import { Router } from "express";

class AuthRoutes {
  path = "/auth";
  router = Router();
  controller = new AuthController();

  constructor() {
    this.init();
  }

  init() {
    this.router.post(this.path + "/login", this.controller.login);
    this.router.post(this.path + "/check-email", this.controller.checkEmail);
    this.router.post(
      this.path + "/verify-token",
      this.controller.validateToken
    );
    this.router.post(
      this.path + "/send-verification-email",
      this.controller.sendVerificationEmail
    );
    this.router.post(this.path + "/verify-email", this.controller.verifyEmail);
    this.router.post(
      this.path + "/reset-password",
      this.controller.resetPassword
    );
    this.router.post(
      this.path + "/register",
      this.controller.upload.single("image"),
      this.controller.register
    );
    this.router.post(
      this.path + "/refresh-token",
      this.controller.refreshToken
    );
  }
}

export default AuthRoutes;
