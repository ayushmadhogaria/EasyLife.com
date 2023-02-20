const express = require("express");
const servicemanRouter = express.Router();
const auth = require("../middlewares/auth");
const ServiceMan = require("../models/serviceman");

servicemanRouter.get("/api/serviceman/", auth, async (req, res) => {
  try {
    const servicemen = await ServiceMan.find({ category: req.query.category });
    res.json(servicemen);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//search product with the use of get request

servicemanRouter.get("/api/serviceman/search/:name", auth, async (req, res) => {
  try {
    const servicemen = await ServiceMan.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    res.json(servicemen);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = servicemanRouter;
