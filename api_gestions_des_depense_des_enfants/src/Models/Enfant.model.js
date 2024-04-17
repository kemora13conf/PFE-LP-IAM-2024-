import mongoose from "mongoose";
const { Schema, model, models } = mongoose;

const enfantSchema = new Schema({
  nom: { type: String, required: true },
  CNE: { type: String, unique: true },
  image: { type: String, default: "enfant-default.png" },
  genre: { type: String, enum: ["M", "F"] },
  ecole: String,
  niveau: String,
  parent: { type: mongoose.Schema.Types.ObjectId, ref: "Parent" }, // Référence au parent
});

const Enfant = models.Enfant || model("Enfant", enfantSchema);
