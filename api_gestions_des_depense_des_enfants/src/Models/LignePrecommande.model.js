import mongoose from "mongoose";
const { Schema, model, models } = mongoose;

const lignePrecommandeSchema = new Schema({
  prixUnitaire: Number,
  quantite: Number,
  precommande: { type: mongoose.Schema.Types.ObjectId, ref: "Precommande" }, // Référence à la précommande
  repas: { type: mongoose.Schema.Types.ObjectId, ref: "Repas" }, // Référence au repas
});

const LignePrecommande = models.LignePrecommande || model("LignePrecommande", lignePrecommandeSchema);
