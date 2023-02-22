const express = require("express");
const mongoose = require("mongoose");
const adminRouter = require("./routes/admin");
mongoose.set("strictQuery", true);
const authRouter = require("./routes/auth");
const userRouter = require("./routes/user");
const servicemanRouter = require("./routes/serviceman");
const PORT = 3000;
const app = express();
const DB =
  "mongodb+srv://ayush:ayush123@cluster0.le1k1mj.mongodb.net/?retryWrites=true&w=majority";

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(servicemanRouter);
app.use(userRouter);

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });
app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
