import mongoose from "mongoose";
const { Schema, model, models } = mongoose;

const repasSchema = new Schema({
  nom: { type: String, required: true },
  prixVente: Number,
  calories: Number,
  image: String,
  quantite: Number,
  categorie: { type: mongoose.Schema.Types.ObjectId, ref: "Categorie" }, // Référence à la catégorie
});

const Repas = models.Repas || model("Repas", repasSchema);