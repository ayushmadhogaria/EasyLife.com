const mongoose = require("mongoose");
const { servicemanSchema } = require("./serviceman");

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Invalid email! Please enter a valid email address",
    },
  },
  password: {
    required: true,
    type: String,
  },
  phone: {
    required: true,
    type: String,
    validate: {
      validator: function (v) {
        return v.length === 10;
      },
      message: "Phone number must be 10 digits.",
    },
  },
  type: {
    type: String,
    required: true,
  },
  address: {
    type: String,
    default: "",
  },
  wishlist: [
    {
      serviceman: servicemanSchema,
      duration: {
        type: Number,
        required: true,
      },
    },
  ],
});

const User = mongoose.model("User", userSchema);
module.exports = User;
