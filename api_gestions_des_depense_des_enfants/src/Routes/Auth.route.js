import AuthController from "../Controllers/Auth.controller.js";
import { Router } from "express";

class AuthRoutes {
    path = '/auth';
    router = Router();
    controller = new AuthController();

    constructor() {
        this.init();
    }

    init() {
        // Middlewares

        // Routes
        this.router.post(this.path + '/login', this.controller.login);
        this.router.post(this.path + '/check-email', this.controller.checkEmail);
        this.router.post(this.path + '/register', this.controller.upload.single("image"), this.controller.register);
        this.router.post(this.path + '/refresh-token', this.controller.refreshToken);
        // this.router.post(this.path + '/logout', this.controller.logout);

    }
}

export default AuthRoutes;