import mongoose from "mongoose";
const { Schema, model, models } = mongoose;

const paiementSchema = new Schema({
  modePaiement: {
    type: String,
    enum: ["carte", "espece", "virement"],
  },
  datePaiement: { type: Date, default: Date.now },
  montant: Number,
});

const Paiment = mongoose.models.Paiment || mongoose.model("Paiment", paiementSchema);
