const express = require("express");
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const Appointment = require("../models/appointment");
const { ServiceMan } = require("../models/serviceman");
const User = require("../models/user");

//add product to the wishlist
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

//remove product from wishlist
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

//post req for saving user address
userRouter.post("/api/save-user-address", auth, async (req, res) => {
  try {
    const { address } = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//booking appointment
userRouter.post("/api/appointment", auth, async (req, res) => {
  try {
    const { wishlist, totalAmount, address, appointDate, appointTime } =
      req.body;

    let servicemans = [];

    for (let i = 0; i < wishlist.length; i++) {
      let serviceman = await ServiceMan.findById(wishlist[i].serviceman._id);
      servicemans.push({ serviceman, duration: wishlist[i].duration });
      await serviceman.save();
    }

    let user = await User.findById(req.user);
    user.wishlist = [];
    user = await user.save();

    let appointment = new Appointment({
      servicemans,
      totalAmount,
      address,
      appointDate,
      appointTime,
      userName,
      userId: req.user,
      requestedAt: new Date().getTime(),
    });
    appointment = await appointment.save();
    res.json(appointment);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//viewing my appointments

userRouter.get("/api/my/appointments", auth, async (req, res) => {
  try {
    const appointments = await Appointment.find({ userId: req.user });
    res.json(appointments);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//delete the appointment
userRouter.post("/api/delete-appointment", auth, async (req, res) => {
  try {
    const { id } = req.body;
    let appointment = await Appointment.findByIdAndDelete(id);
    res.json(appointment);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
