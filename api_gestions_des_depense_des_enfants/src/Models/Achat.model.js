import mongoose from "mongoose";
const { Schema, model, models } = mongoose;

const achatSchema = new Schema({
  dateAchat: { type: Date, default: Date.now },
  statut: { type: String, enum: ["en cours", "termine", "annule"] },
  heureAchat: Date,
  lignesAchat: [{ type: mongoose.Schema.Types.ObjectId, ref: "LigneAchat" }], // Référence aux lignes d'achat
});

const Achat = models.Achat || model("Achat", achatSchema);
