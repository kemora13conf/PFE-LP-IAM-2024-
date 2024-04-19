import mongoose from "mongoose";
import ParentModel from "./Parent.model.js";
const { Schema, model, models } = mongoose;

const enfantSchema = new Schema({
  nom: { type: String, required: true },
  CNE: { type: String, unique: true },
  image: { type: String, default: "enfant-default.png" },
  genre: { type: String, enum: ["Male", "Female"] },
  ecole: String,
  niveau: String,
  parent: { type: mongoose.Schema.Types.ObjectId, ref: "Parent" }, // Référence au parent
});

enfantSchema.pre("save", async function (next) {
  if (this.isModified("parent")) {
    const parent = await ParentModel.findById(this.parent);
    if (!parent) {
      throw new Error("Parent not found");
    }
    parent.enfants = [...parent.enfants, this._id];
    await parent.save();
  }
  next();
});

export default models.Enfant || model("Enfant", enfantSchema);
