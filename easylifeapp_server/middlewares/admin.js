const jwt = require("jsonwebtoken");
const User = require("../models/user");
const admin = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res
        .status(401)
        .json({ msg: "Auth token unavailable, access denied" });

    const isVerified = jwt.verify(token, "passwordKey");
    if (!isVerified)
      return res
        .status(401)
        .json({ msg: "Could not authorize. Token verification failed." });
    const user = await User.findById(isVerified.id);
    if (user.type == "Customer") {
      return res.status(401).json({ msg: "You are not an admin!" });
    }
    req.user = isVerified.id;
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = admin;
