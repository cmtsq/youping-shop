const express = require('express');
const userCtr = require('../control/userCtr');
const userRouter = express.Router();

//登录页面显示
userRouter.get('/login',(req,res)=>{
    res.render('login.html');
});
//注册表单跳转
userRouter.post('/doReg',(req,res)=>{
    userCtr.regUser(req,res);
});
//注册表单用户效验
userRouter.post('/checkReg',(req,res)=>{
    userCtr.checkUser(req,res);
});
//登录表单跳转
userRouter.post('/doLog',(req,res)=>{
    userCtr.logUser(req,res);
});
//退出登录
userRouter.get('/logout',(req,res)=>{
    userCtr.logout(req,res);
});

module.exports = userRouter;