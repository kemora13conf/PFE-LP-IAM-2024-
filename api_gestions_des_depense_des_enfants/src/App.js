import express, { Router } from "express";
import Logger from "./Lib/Logger.js";
import {
  NODE_ENV,
  PORT,
  IS_PROJECT_INSTALLED,
  changeIsProjectInstalledToTrue,
} from "./Config/index.js";
import ParentModel from "./Models/Parent.model.js";
import db from "./Database.js";
import os from "os";

export default class App {
  constructor(routes) {
    this.app = express();
    this.port = PORT || 3000;
    this.env = NODE_ENV;
    this.routes = routes;

    this.initMidlware();
    this.initRoutes();
    this.initApp();
  }

  initMidlware() {
    this.app.use(express.json());
    
    // assets
    this.app.use('/assets', express.static("public"));

    this.app.use((req, res, next) => {
      Logger.debug(`[${req.method}] ${req.url}`);
      next();
    });
  }

  initRoutes() {
    this.routes.forEach((route) => {
      this.app.use("/api", route.router);
    });
  }

  async initApp() {
    await db.getInstance();
    if (IS_PROJECT_INSTALLED === "false") {
      // init the parent model and create a parent
      try {
        const parent = new ParentModel({
          email: "parent@gmail.com",
          hashed_password: "123456",
          nom: "Parent",
          adresse: "Yaoundé",
          genre: "Male",
        });
        await parent.save();
        Logger.info("====== DB STATE: Parent created ======");
        changeIsProjectInstalledToTrue();
      } catch (err) {
        Logger.error("====== DB STATE: Parent creation failed ======");
        throw new Error(err.message);
      }
    }
  }

  _getLocalIp() {
    const interfaces = Object.keys(os.networkInterfaces());
    const localIp = os.networkInterfaces()[interfaces[0]][1].address;
    return localIp;
  }

  listen() {
    this._getLocalIp();
    this.app.listen(this.port, "0.0.0.0", () => {
      Logger.info(`==========================================`);
      Logger.info(`============ ENV: ${this.env} ============`);
      Logger.info(`🚀 App listening on the port ${this.port}`);
      Logger.info(`🏃 Running on http://${this._getLocalIp()}:${this.port}`);
      Logger.info(`==========================================`);
    });
  }
}
