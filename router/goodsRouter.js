const express = require('express');
const goodsCtr = require('../control/goodsCtr');
const goodsRouter = express.Router();

//首页页面显示
goodsRouter.get('/index',(req,res)=>{
    goodsCtr.showIndex(req,res);
});
//商品详情页的显示
goodsRouter.get('/goods_detail',(req,res)=>{
    goodsCtr.showGoodsDetail(req,res);
});
//模糊查询商品渲染结果
goodsRouter.post('/doSearchGoods',(req,res)=>{
    goodsCtr.showSearch(req,res);
});
//收藏商品
goodsRouter.get('/collect',(req,res)=>{
    goodsCtr.collect(req,res);
});
//取消收藏
goodsRouter.get('/cancelCollect',(req,res)=>{
    goodsCtr.delCollect(req,res);
});

module.exports = goodsRouter;