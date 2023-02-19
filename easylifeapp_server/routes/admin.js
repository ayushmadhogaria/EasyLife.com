const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const ServiceMan = require("../models/serviceman");

// add serviceman
adminRouter.post("/admin/add-serviceman", admin, async (req, res) => {
  try {
    const {
      name,
      description,
      salary,
      address,
      phone,
      shift,
      time,
      category,
      images,
    } = req.body;
    let serviceman = new ServiceMan({
      name,
      description,
      salary,
      address,
      phone,
      shift,
      time,
      category,
      images,
    });
    serviceman = await serviceman.save();
    res.json(serviceman);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//fetch all the serviceman

adminRouter.get("/admin/get-serviceman", admin, async (req, res) => {
  try {
    const servicemen = await ServiceMan.find({});
    res.json(servicemen);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//delete the serviceman
adminRouter.post("/admin/delete-serviceman", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let serviceman = await ServiceMan.findByIdAndDelete(id);
    res.json(serviceman);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;
