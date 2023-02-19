const mongoose = require("mongoose");

const servicemanSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  salary: {
    type: Number,
    required: true,
  },
  phone: {
    type: String,
    required: true,
    validate: {
      validator: function (v) {
        return v.length === 10;
      },
      message: "Phone number must be 10 digits.",
    },
  },
  address: {
    type: String,
    required: true,
  },
  shift: {
    type: String,
    required: true,
  },
  time: {
    type: String,
    required: true,
  },
  category: {
    type: String,
    required: true,
  },
  images: [
    {
      type: String,
      required: true,
    },
  ],
});

const ServiceMan = mongoose.model("ServiceMan", servicemanSchema);
module.exports = ServiceMan;
