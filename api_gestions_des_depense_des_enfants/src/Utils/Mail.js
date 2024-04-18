import nodemailer from "nodemailer";
import {
  EMAIL_SERVICE,
  EMAIL_USERNAME,
  EMAIL_PASSWORD,
  EMAIL_PORT,
} from "../Config/index.js";
import Logger from "../Lib/Logger.js";
import path from "path";
import fs from "fs";
import { __dirname } from "../Server.js";

export default class Mail {
  constructor(code, to) {
    this.transporter = nodemailer.createTransport({
      service: EMAIL_SERVICE,
      secure: false,
      port: EMAIL_PORT,
      auth: {
        user: EMAIL_USERNAME,
        pass: EMAIL_PASSWORD,
      },
    });
    this.code = code;
    this.to = to;
    this.emailBody = this.prepareEmailBody(to, code);
  }
  prepareEmailBody(userName, verificationCode) {
    // Load the email template
    const templatePath = path.join(__dirname, "./Utils/email_template.html");
    const template = fs.readFileSync(templatePath, "utf-8");

    // Fill in the placeholders
    const emailBody = template
      .replace("[User Name]", userName)
      .replace("[Verification Code]", verificationCode);

    return emailBody;
  }
  async send() {
    const mailOptions = {
      from: EMAIL_USERNAME,
      to: this.to,
      subject: "Email Verification",
      html: this.emailBody
    };
    const emailInfo = await this.transporter.sendMail(mailOptions);
    Logger.info(`====== Email Sent ======`);
    Logger.info(`To: ${this.to}`);
    Logger.info(`Code: ${this.code}`);
    Logger.info(`========================`);
    return emailInfo;
  }
}
