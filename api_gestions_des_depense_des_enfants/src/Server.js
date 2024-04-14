import App from './App.js';
import AuthRoutes from './Routes/Auth.route.js';

const app = new App([new AuthRoutes()]);
app.listen();