const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const session = require('express-session');
var app = express();
app.listen(3000,'127.0.0.1',()=>{
    console.log('服务器已经启动');
});
app.use(session({
    secret:'cm20025',
    resave:false,
    saveUninitialized:true
}));
app.use('/public',express.static(path.join(__dirname,'public')));
app.engine('html',require('express-art-template'));
app.use(bodyParser.urlencoded({extended:false}));
app.use('/user',require('./router/userRouter'));
app.use('/goods',require('./router/goodsRouter'));
app.use('/cart',require('./router/cartRouter'));
app.use('/personal',require('./router/personalRouter'));
app.use('/admin',require('./router/adminRouter'));
app.use('/admin',(req,res,next)=>{
    var adminID = req.session.adminID;
    if(!adminID){
        res.send("<script>alert('请先登录');window.location.href='/admin/admin_login'</script>");
    }else{
        next();
    }
});