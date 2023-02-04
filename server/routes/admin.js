const express = require('express');
const admin = require('../middlewares/admin');
const adminRouter = express.Router();

const {Product} = require('../models/product');

//Add Product
adminRouter.post('/admin/add-product', admin, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category } = req.body;
        let product = new Product(
            {
                name,
                description,
                images,
                quantity,
                price,
                category
            }
        );
        //Whatevr the ongodb is returning us the product id and product name is taken in the 
        //non const variable product
        product = await product.save();
        res.json(product);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//get all the products
adminRouter.get('/admin/get-products', admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);
    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//delete the product
adminRouter.post('/admin/delete-product', admin, async (req, res) => {
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }
});


module.exports = adminRouter;
