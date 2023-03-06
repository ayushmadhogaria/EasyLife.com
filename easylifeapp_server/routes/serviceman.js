const express = require("express");
const servicemanRouter = express.Router();
const auth = require("../middlewares/auth");
const { ServiceMan } = require("../models/serviceman");

//show all the serviceman
servicemanRouter.get("/api/serviceman/", auth, async (req, res) => {
  try {
    const servicemen = await ServiceMan.find({ category: req.query.category });
    res.json(servicemen);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//search serviceman with the use of get request
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

//post route for rating the serviceman
servicemanRouter.post("/api/rate-serviceman", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    let serviceman = await ServiceMan.findById(id);

    for (let i = 0; i < serviceman.ratings.length; i++) {
      if (serviceman.ratings[i].userId == req.user) {
        serviceman.ratings.splice(i, 1);
        break;
      }
    }

    const ratingSchema = {
      userId: req.user,
      rating,
    };

    serviceman.ratings.push(ratingSchema);
    serviceman = await serviceman.save();
    res.json(serviceman);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//recommend the serviceman with highest rating
servicemanRouter.get("/api/recommended-for-you", auth, async (req, res) => {
  try {
    let servicemen = await ServiceMan.find({});

    servicemen.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;

      for (let i = 0; i < a.ratings.length; i++) {
        aSum += a.ratings[i].rating;
      }

      for (let i = 0; i < b.ratings.length; i++) {
        bSum += b.ratings[i].rating;
      }

      return aSum < bSum ? 1 : -1;
    });

    res.json(servicemen[0]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = servicemanRouter;
