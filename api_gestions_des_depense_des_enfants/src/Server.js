import App from './App.js';
import AuthRoutes from './Routes/Auth.route.js';
import { fileURLToPath } from "url";
import path, { dirname } from "path";
import Logger from './Lib/Logger.js';
import EnfantsRoute from './Routes/Enfants.route.js';

export const __filename = fileURLToPath(import.meta.url);
export const __dirname = dirname(__filename);

const app = new App([new AuthRoutes(), new EnfantsRoute()]);
app.listen();