import mongoose from "mongoose";
const { Schema, model, models } = mongoose;

const ligneAchatSchema = new Schema({
  prixUnitaireAchat: Number,
  quantite: Number,
  statut: { type: String, enum: ["en cours", "termine", "annule"] },
  achat: { type: mongoose.Schema.Types.ObjectId, ref: "Achat" }, // Référence à l'achat
  repas: { type: mongoose.Schema.Types.ObjectId, ref: "Repas" }, // Référence au repas
});

const LigneAchat = models.LigneAchat || model("LigneAchat", ligneAchatSchema);