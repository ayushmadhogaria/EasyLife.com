const express = require("express");
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const { ServiceMan } = require("../models/serviceman");
const User = require("../models/user");

userRouter.post("/api/add-to-wishlist", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const serviceman = await ServiceMan.findById(id);
    let user = await User.findById(req.user);

    if (user.wishlist.length == 0) {
      user.wishlist.push({ serviceman, duration: 1 });
    } else {
      let isServicemanFound = false;
      for (let i = 0; i < user.wishlist.length; i++) {
        if (user.wishlist[i].serviceman._id.equals(serviceman._id)) {
          isServicemanFound = true;
        }
      }

      if (isServicemanFound) {
        let servicem = user.wishlist.find((servicem) =>
          servicem.serviceman._id.equals(serviceman._id)
        );
        servicem.duration += 1;
      } else {
        user.wishlist.push({ serviceman, duration: 1 });
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.delete("/api/remove-from-wishlist/:id", auth, async (req, res) => {
  try {
    const { id } = req.params;
    const serviceman = await ServiceMan.findById(id);
    let user = await User.findById(req.user);

    for (let i = 0; i < user.wishlist.length; i++) {
      if (user.wishlist[i].serviceman._id.equals(serviceman._id)) {
        if (user.wishlist[i].duration == 1) {
          user.wishlist.splice(i, 1);
        } else {
          user.wishlist[i].duration -= 1;
        }
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
