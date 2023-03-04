const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const { ServiceMan } = require("../models/serviceman");
const Appointment = require("../models/appointment");

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

//get all the serviceman

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

//view all appointments
adminRouter.get("/admin/get-appointments", admin, async (req, res) => {
  try {
    const appointments = await Appointment.find({});
    res.json(appointments);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//change appointment status
adminRouter.post(
  "/admin/change-appointment-status",
  admin,
  async (req, res) => {
    try {
      const { id, status } = req.body;
      let appointment = await Appointment.findById(id);
      appointment.status = status;
      appointment = await appointment.save();
      res.json(appointment);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

//viewing the total earnings
adminRouter.get("/admin/analytics", admin, async (req, res) => {
  try {
    const appointments = await Appointment.find({});
    let totalEarnings = 0;

    for (let i = 0; i < appointments.length; i++) {
      for (let j = 0; j < appointments[i].servicemans.length; j++) {
        totalEarnings +=
          appointments[i].servicemans[j].duration *
          appointments[i].servicemans[j].serviceman.salary;
      }
    }

    //details of category wise earning
    let maidEarnings = await fetchCategoryWiseServiceman("Maid");
    let driverEarnings = await fetchCategoryWiseServiceman("Driver");
    let cookEarnings = await fetchCategoryWiseServiceman("Cook");
    let babySitterEarnings = await fetchCategoryWiseServiceman("BabySitter");
    let oldageCareEarnings = await fetchCategoryWiseServiceman("OldAgeCare");

    let earnings = {
      totalEarnings,
      maidEarnings,
      driverEarnings,
      cookEarnings,
      babySitterEarnings,
      oldageCareEarnings,
    };
    res.json(earnings);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

async function fetchCategoryWiseServiceman(category) {
  let earnings = 0;
  let categoryAppointments = await Appointment.find({
    "servicemans.serviceman.category": category,
  });
  for (let i = 0; i < categoryAppointments.length; i++) {
    for (let j = 0; j < categoryAppointments[i].servicemans.length; j++) {
      earnings +=
        categoryAppointments[i].servicemans[j].duration *
        categoryAppointments[i].servicemans[j].serviceman.salary;
    }
  }
  return earnings;
}

module.exports = adminRouter;
