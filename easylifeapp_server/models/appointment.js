const mongoose = require("mongoose");
const { servicemanSchema } = require("./serviceman");
const User = require("./user");

const appointmentSchema = mongoose.Schema({
  servicemans: [
    {
      serviceman: servicemanSchema,
      duration: {
        type: Number,
        required: true,
      },
    },
  ],
  totalAmount: {
    type: Number,
    required: true,
  },
  address: {
    type: String,
    required: true,
  },
  userName: {
    type: String,
    required: true,
  },
  userContact: {
    type: String,
    required: true,
  },
  appointDate: {
    type: String,
    required: true,
  },
  appointTime: {
    type: String,
    required: true,
  },
  userId: {
    type: String,
    required: true,
  },
  requestedAt: {
    type: Number,
    required: true,
  },
  status: {
    type: Number,
    default: 1,
  },
  // user: User.userSchema,
});

const Appointment = mongoose.model("Appointment", appointmentSchema);
module.exports = Appointment;
