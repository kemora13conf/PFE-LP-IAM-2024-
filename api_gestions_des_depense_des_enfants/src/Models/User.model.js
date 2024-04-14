import mongoose from "mongoose";
import bcrypt from "bcrypt";
import CryptoJS from "crypto-js";

const { model, models, Schema } = mongoose;

export const UserSchema = new Schema({
  email: {
    type: String,
    required: true,
    unique: true,
  },
  username: {
    type: String,
    required: true,
    unique: true,
  },
  hashed_password: {
    type: String,
    required: true,
  },
  salt: {
    type: String,
    default: ""
  },
  image: {
    type: String,
    default: "avatar.png",
  },
  bio: {
    type: String,
    required: false,
    default: "Hey there! I'm using WhatsApp",
  },
  otp: {
    type: String,
    default: null,
  },
  isVerified: {
    type: Boolean,
    required: true,
    default: false,
  },
  refreshToken: {
    type: String,
    required: false,
  },
  createdAt: {
    type: Date,
    required: true,
    default: Date.now,
  },
  updatedAt: {
    type: Date,
    required: true,
    default: Date.now,
  },
});

// Hash password before saving
UserSchema.pre("save", async function (next) {
  if (!this.isModified("hashed_password")) return next();
  this.salt = await bcrypt.genSalt(10);
  this.hashed_password = CryptoJS
    .SHA256(this.hashed_password + this.salt)
    .toString();
  next();
});

// Compare password
// This method require having an instance of the user
UserSchema.methods = {
  isPasswordMatch: async function (password) {
    return CryptoJS
            .SHA256(password + this.salt)
            .toString() === this.hashed_password;
  }
}

UserSchema.methods.minimize = function () {
  return {
    _id: this._id,
    email: this.email,
    username: this.username,
    image: this.image,
    bio: this.bio,
    isVerified: this.isVerified,
    createdAt: this.createdAt,
    updatedAt: this.updatedAt,
  };
};

export default model("User", UserSchema) || models.User;
