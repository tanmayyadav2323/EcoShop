//Imports from packages
const express = require('express');
const mongoose = require('mongoose');
const adminRouter = require('./routes/admin');

//Import from other files
const authRouter = require('./routes/auth');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

//Init
const port = 3000
const app = express();
const DB = "mongodb+srv://Tanmay:Tanmay%402001@cluster0.3bnbusc.mongodb.net/?retryWrites=true&w=majority";

//middleware
app.use(express.json());
app.use(authRouter);
app.use(productRouter);
app.use(adminRouter);
app.use(userRouter);

app.get("/hello-world", (req, res) => {
    res.send("Hello world");
});

//Connections
mongoose.connect(DB).then(() => {
    console.log("Connection Successful");
}).catch((e) => {
    console.log(e);
});

//Creating an API
app.listen(port, "0.0.0.0", () => {
    console.log('Connected at port' + port);
});

