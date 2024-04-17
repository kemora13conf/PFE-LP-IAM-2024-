import mongoose from "mongoose";
const { Schema, model, models } = mongoose;

const precommandeSchema = new Schema({
  datePrecommande: { type: Date, default: Date.now },
  etat: { type: String, enum: ["en attente", "confirmee", "annulee"] },
  paiement: { type: mongoose.Schema.Types.ObjectId, ref: "Paiement" }, // Référence au paiement
  lignesPrecommande: [
    { type: mongoose.Schema.Types.ObjectId, ref: "LignePrecommande" },
  ], // Référence aux lignes de précommande
  parent: { type: mongoose.Schema.Types.ObjectId, ref: "Parent" }, // Référence au parent
});

const Precommande = models.Precommande || model("Precommande", precommandeSchema);