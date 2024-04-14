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
        this.router.post(this.path+'/login', this.controller.login);
    }
}

export default AuthRoutes;