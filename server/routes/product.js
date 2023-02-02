const express = require("express");
const auth = require("../middlewares/auth");
const Product = require("../models/product");
const productRouter = express.Router();

//api/product?catgory=Essentials
//api/amazon?theme=dark
//--> req.query.theme

//api/products:catgory=Essentials
//-->req.query.params

productRouter.get("/api/products", auth, async (req, res) => {
    try {
        const products = await Product.find({
            category: req.query.category
        });
        res.json(products);
    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//create a get requestto search products and get them

productRouter.get("/api/products/search/:name", auth, async (req, res) => {
    try {
        const products = await Product.find({
            name: {$regex: req.params.name,$options: "i"},
        });
        res.json(products);
    }
    catch
    {
        res.status(500).json({ error: e.message });
    }
});

module.exports = productRouter;