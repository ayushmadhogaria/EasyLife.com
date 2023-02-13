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
      phone,
      shift,
      worktime,
      category,
      images,
    } = req.body;
    let serviceman = new ServiceMan({
      name,
      description,
      salary,
      phone,
      shift,
      worktime,
      category,
      images,
    });
    serviceman = await serviceman.save();
    res.json(serviceman);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;
