import express, { Router } from 'express';
import Logger  from './Lib/Logger.js';
import { NODE_ENV, PORT } from './Config/index.js';
import os from 'os'
import { log } from 'console';

export default class App{
    constructor (routes) {
        this.app = express();
        this.port = PORT || 3000;
        this.env = NODE_ENV;
        this.routes = routes;
        
        this.initMidlware()
        this.initRoutes();
    }

    initMidlware() {
        this.app.use(express.json());
        // this.app.use(express.urlencoded({ extended: true }));
        this.app.use((req, res, next) => {
            Logger.debug(`[${req.method}] ${req.url}`)
            next()
        })
    }   

    initRoutes() {
        this.routes.forEach(route => {
            this.app.use('/api', route.router);
        });
    }

    _getLocalIp(){
        const interfaces = Object.keys(os.networkInterfaces())
        const localIp = os.networkInterfaces()[interfaces[0]][1].address
        return localIp
    }

    listen() {
        this._getLocalIp()
        this.app.listen(this.port, '0.0.0.0', () => {
            Logger.info(`==========================================`);
            Logger.info(`============ ENV: ${this.env} ============`);
            Logger.info(`🚀 App listening on the port ${this.port}`);
            Logger.info(`🏃 Running on http://${this._getLocalIp()}:${this.port}`)
            Logger.info(`==========================================`);
        });
    }
}