import mongoose from 'mongoose';
import Logger from './Lib/Logger.js';

export default class Database {
    static instance = null;

    static async getInstance() {
        if (this.instance === null) {
            try {
                const connection = await mongoose.connect('mongodb://localhost:27017/ChatApp', {});
                this.instance = connection.connection;
                Logger.info('====== DB STATE: Database connected ======');
                return this.instance;
            } catch(err){
                Logger.error('====== DB STATE: Database connection failed ======');
                throw new Error(err.message);
            }
        }

        return this.instance;
    }
}