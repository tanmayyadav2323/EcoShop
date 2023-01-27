const express = require("express");
const User = require("../models/user");
const bcryptjs = require('bcryptjs');
const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
    try {
        const { name, email, password } = req.body;

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "User with smae email already exists" });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);
        let user = new User({
            email,
            password: hashedPassword,
            name,
        })


        user = await user.save();
        // it will give back the version and the id
        res.json(user);
        //status Code
        //'name' : name , 'email' : email,'passowrd' : password
        //
        //get the data from client
        //post the data in database
        //return that data to the user
    }
    catch (e) {
        res.status(500).json({ error: e.message });
    };
});

authRouter.get('/user', (req, res) => {
    res.json({ msg: "tanmay" });
});

module.exports = authRouter;