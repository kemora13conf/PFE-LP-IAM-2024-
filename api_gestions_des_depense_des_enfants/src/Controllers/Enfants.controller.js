import Logger from "../Lib/Logger.js";
import ResponseAsnwer from "../Utils/index.js";
import db from "../Database.js";
import ParentModel from "../Models/Parent.model.js";

class EnfantsController {
  async enfants(req, res) {
    try {
      await db.getInstance();
      const parent = await ParentModel.findById(req.parent._id).populate({
        path: "enfants",
        model: "Enfant",
        populate: {
          path: "parent",
          model: "Parent",
        },
      });
      return res
        .status(200)
        .json(
          ResponseAsnwer("ENFANTS_FETCHED", "Enfants fetched", parent.enfants)
        );
    } catch (err) {
      return res
        .status(200)
        .json(ResponseAsnwer("SERVER_ERR", err.message, []));
    }
  }
  async createEnfant(req, res) {
    try {
      await db.getInstance();
      const parent = await ParentModel.findById(req.parent._id);
      const enfant = new EnfantModel({ ...req.body, parent: parent._id });
      await enfant.save();
      return res
        .status(200)
        .json(ResponseAsnwer("ENFANT_CREATED", "Enfant created", enfant));
    } catch (err) {
      return res
        .status(500)
        .json(ResponseAsnwer("SERVER_ERR", err.message, []));
    }
  }
}

export default EnfantsController;
