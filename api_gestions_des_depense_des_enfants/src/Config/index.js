import { config } from "dotenv";
config({ path: `.env.${process.env.NODE_ENV || "development"}.local` });
import fs from "fs";
import path from "path";
import { __dirname } from "../Server.js";
import Logger from "../Lib/Logger.js";

export const {
  PORT,
  NODE_ENV,
  ACCESS_TOKEN_KEY,
  REFRESH_ACCESS_TOKEN_KEY,
  DATABASE_URL,
  IS_PROJECT_INSTALLED,
} = process.env;

// function change the IS_PROJECT_INSTALLED in the .env.development.local file to true
export function changeIsProjectInstalledToTrue() {
  const filePath = path.resolve(__dirname, "../.env.development.local");
  fs.readFile(filePath, "utf8", function (err, data) {
    if (err) {
      return console.log(err);
    }
    const result = data.replace(
      /IS_PROJECT_INSTALLED=false/g,
      "IS_PROJECT_INSTALLED=true"
    );
    fs.writeFile(filePath, result, "utf8", function (err) {
        if (err) return console.log(err);
        Logger.info("====== IS_PROJECT_INSTALLED changed to true ======");
    });
  });
}
