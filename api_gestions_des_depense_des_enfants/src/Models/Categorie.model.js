import mongoose from "mongoose";
const { Schema, model, models } = mongoose;

const categorieSchema = new Schema({
  nomCategorie: { type: String, required: true },
  repas: [{ type: mongoose.Schema.Types.ObjectId, ref: "Repas" }], // Reference to meals
});

const Categorie = models.Categorie || model("Categorie", categorieSchema);
