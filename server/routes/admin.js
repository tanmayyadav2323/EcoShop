const express = require('express');
const admin = require('../middlewares/admin');
const adminRouter = express.Router();
const Order = require('../models/order');
const { Product } = require('../models/product');

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

adminRouter.get("/admin/analytics", admin, async (req, res) => {
    try {
        const orders = await Order.find();
        let totalEarnings = 0;

        for (let i = 0; i < orders.length; i++) {
            for (let j = 0; j < orders[i].products.length; j++) {
                totalEarnings +=
                    orders[i].products[j].quantity * orders[i].products[j].product.price;
            }
        }
        // CATEGORY WISE ORDER FETCHING
        let containerEarnings = await fetchCategoryWiseProduct("Containers");
        let skinCareEarnings = await fetchCategoryWiseProduct("SkinCares");
        let homegoodEarnings = await fetchCategoryWiseProduct("HomeGoods");
        let PackagingsEarnings = await fetchCategoryWiseProduct("Packagings");
        let fashionEarnings = await fetchCategoryWiseProduct("Fashion");

        let earnings = {
            totalEarnings,
            containerEarnings,
            skinCareEarnings,
            homegoodEarnings,
            PackagingsEarnings,
            fashionEarnings,
        };

        res.json(earnings);
    } catch (e) {
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

async function fetchCategoryWiseProduct(category) {
    let earnings = 0;
    let categoryOrders = await Order.find({
        "products.product.category": category,
    });

    for (let i = 0; i < categoryOrders.length; i++) {
        for (let j = 0; j < categoryOrders[i].products.length; j++) {
            earnings +=
                categoryOrders[i].products[j].quantity *
                categoryOrders[i].products[j].product.price;
        }
    }
    return earnings;
}


module.exports = adminRouter;
