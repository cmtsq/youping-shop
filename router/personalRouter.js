const express = require('express');
const personalCtr = require('../control/personalCtr');
const goodsCtr = require('../control/goodsCtr');
const personalRouter = express.Router();

//提交订单
personalRouter.post('/confirmOrder',(req,res)=>{
    personalCtr.confirmOrder(req,res);
});
//个人中心页面显示
personalRouter.get('/people',(req,res)=>{
    personalCtr.showPersonalCenter(req,res);
});
//订单信息显示
personalRouter.get('/order',(req,res)=>{
    personalCtr.showOrder(req,res);
});
//收藏信息显示
personalRouter.get('/collect',(req,res)=>{
    personalCtr.showCollect(req,res);
});
//取消收藏
personalRouter.get('/delOneselfCollect',(req,res)=>{
    goodsCtr.delOneselfCollect(req,res);
});
//个人地址信息展示
personalRouter.get('/address',(req,res)=>{
    personalCtr.showAddress(req,res);
});
//评论商品
personalRouter.post('/doAddComment',(req,res)=>{
    personalCtr.remarkGoods(req,res);
});
//渲染添加地址页
personalRouter.get('/addAddress',(req,res)=>{
    res.render('addAddress.html');
});
//渲染修改地址页
personalRouter.get('/updateAddress',(req,res)=>{
    personalCtr.updateAddress(req,res);
});
//添加地址
personalRouter.post('/doAddAddress',(req,res)=>{
    personalCtr.addAddress(req,res);
});
//修改地址
personalRouter.post('/doUpdateAddress',(req,res)=>{
    personalCtr.doUpdateAddress(req,res);
});
//删除地址
personalRouter.get('/delAddress',(req,res)=>{
    personalCtr.doDelAddress(req,res);
});
//确认收货
personalRouter.get('/confirmReceipt',(req,res)=>{
    personalCtr.confirmReceiptGoods(req,res);
});
//我的评价
personalRouter.get('/remark',(req,res)=>{
    personalCtr.showMyRemark(req,res);
});
//删除评论
personalRouter.get('/delRemark',(req,res)=>{
    personalCtr.delMyRemark(req,res);
});
//个人资料
personalRouter.get('/oneself',(req,res)=>{
    personalCtr.showOneself(req,res);
});
//修改资料信息
personalRouter.get('/updateOneself',(req,res)=>{
    personalCtr.updateOneself(req,res);
});
personalRouter.post('/doUpdateOneself',(req,res)=>{
    personalCtr.doUpdateOneself(req,res);
});

module.exports = personalRouter;