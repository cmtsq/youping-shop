const express = require('express');
const cartCtr = require('../control/cartCtr');
const cartRouter = express.Router();

//购物车页面显示
cartRouter.get('/showCart',(req,res)=>{
    cartCtr.showCart(req,res);
});
//添加商品到购物车跳转
cartRouter.post('/doAddCart',(req,res)=>{
    cartCtr.addGoodsToCart(req,res);
});
//删除商品
cartRouter.get('/delCartGoods',(req,res)=>{
    cartCtr.delCartGoods(req,res);
});
//批量删除所需删除的商品
cartRouter.post('/delCheckGoods',(req,res)=>{
    cartCtr.delCheckGoods(req,res);
});
//结算页面显示
cartRouter.post('/doPlace',(req,res)=>{
    cartCtr.toSettle(req,res)
});
//修改购物车商品增加数量
cartRouter.post('/updateCartAddNum',(req,res)=>{
    cartCtr.updateAddNum(req,res);
});
//修改购物车商品减少数量
cartRouter.post('/updateCartSubNum',(req,res)=>{
    cartCtr.updateSubNum(req,res);
});

module.exports = cartRouter;