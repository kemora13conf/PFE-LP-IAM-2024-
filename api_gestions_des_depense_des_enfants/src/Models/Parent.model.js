import mongoose from "mongoose";
import bcrypt from "bcrypt";
import CryptoJS from "crypto-js";
const { Schema, model, models } = mongoose;

const parentSchema = new Schema({
  nom: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  hashed_password: {
    type: String,
    required: true,
  },
  salt: {
    type: String,
    default: "",
  },
  solde: { type: Number, default: 0 },
  genre: { type: String, enum: ["Male", "Female"] },
  otp: {
    type: String,
    default: null,
  },
  isVerified: {
    type: Boolean,
    required: true,
    default: false,
  },
  image: {
    type: String,
    default: "parent-default.png",
  },
  enfants: [{ type: mongoose.Schema.Types.ObjectId, ref: "Enfant" }], // Référence aux enfants
  precommandes: [{ type: mongoose.Schema.Types.ObjectId, ref: "Precommande" }], // Référence aux précommandes
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

parentSchema.pre("save", async function (next) {
  if (!this.isModified("hashed_password")) return next();
  this.salt = await bcrypt.genSalt(10);
  this.hashed_password = CryptoJS.SHA256(
    this.hashed_password + this.salt
  ).toString();
  next();
});

// Compare password
// This method require having an instance of the user
parentSchema.methods = {
  isPasswordMatch: async function (password) {
    return (
      CryptoJS.SHA256(password + this.salt).toString() === this.hashed_password
    );
  },
};

// minimize the amount of data returned
parentSchema.methods.minimize = function () {
  const parentObject = this.toObject();
  delete parentObject.hashed_password;
  delete parentObject.salt;
  delete parentObject.otp;
  return parentObject;
};

export default models.Parent || model("Parent", parentSchema);
