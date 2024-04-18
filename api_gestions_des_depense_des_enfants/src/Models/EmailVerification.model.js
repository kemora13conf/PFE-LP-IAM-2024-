import e from "express";
import mongoose from "mongoose";

const { Schema, models, model } = mongoose;

const emailVerificationSchema = new Schema({
    email: {
        type: String,
        required: true,
    },
    token: {
        type: String,
        required: true,
        default: "",
    },
    emailId: {
        type: String,
        required: true,
        default: "",
    },
    emailType: {
        type: String,
        required: true,
        default: "register",
        enum: ["register", "forgot-password"],
    },
    isVerified: {
        type: Boolean,
        required: true,
        default: false,
    },
    expiresAt: {
        type: Date,
        required: true,
        default: Date.now(),
    },
});
    
export default models.EmailVerification || model("EmailVerification", emailVerificationSchema);