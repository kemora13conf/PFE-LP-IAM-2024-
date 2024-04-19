import AuthController from "../Controllers/Auth.controller.js";
import { Router } from "express";
import EnfantsController from "../Controllers/Enfants.controller.js";

class EnfantsRoute{
    path = "/enfants";
    router = new Router();
    controller = new EnfantsController();

    constructor() {
        this.init();
    }

    init() {
        this.router.get(this.path, AuthController.loginRequired, this.controller.enfants);
        this.router.post(this.path, AuthController.loginRequired, this.controller.createEnfant);
    }
}

export default EnfantsRoute;