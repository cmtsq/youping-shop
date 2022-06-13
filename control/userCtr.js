const userDao = require('../dao/userDao');

//注册功能
function regUser(req,res) {
    var user_head = req.body.head_img;
    var user_name = req.body.reg_user;
    var user_pass = req.body.reg_pass;
    userDao.inserUser([user_head,user_name,user_pass],(err,result)=>{
        if(err){
            return res.end(err.message);
        }
        res.send("<script>alert('注册成功');window.location.href='/user/login'</script>");
    });
}
//用户效验
function checkUser(req,res) {
    var user_name = req.body.userReg;
    userDao.selectUser("where user_name=?",[user_name],(err,result)=>{
        if(err){
            res.send(err.message);
        }
        //将查询到的记录数发送给客户端
        res.send({userCount:result.length});
    });
}
//登录功能
function logUser(req,res) {
    var user_name = req.body.log_user;
    var user_pass = req.body.log_pass;
    userDao.selectUser('where user_name=? and user_pass=?',[user_name,user_pass],(err,result)=>{
        if(err){
            return res.end(err.message);
        }
        if(result.length>0){
            //将用户名和用户ID保存在session中
            req.session.user_name = result[0].user_name;
            req.session.userID= result[0].userID;
            if(result[0].user_status=='冻结'){
                res.send("<script>alert('您的账号已被冻结，请联系管理员解除！');window.location.href='/user/login'</script>");
            }else if(result[0].user_status=='存在风险'){
                res.send("<script>alert('您的账号存在风险，请谨慎登录');window.location.href='/goods/index'</script>");
            }else{
                res.send("<script>alert('登录成功');window.location.href='/goods/index'</script>");
            }
        }else{
            res.send("<script>alert('用户名或者密码错误,请重试');window.location.href='/user/login'</script>");
        }
    });
}
//退出登录
function logout(req,res){
    //清除登录时存储在session中的值
    req.session.user_name = null;
    req.session.userID = null;
    res.send("<script>window.location.href='/user/login'</script>");
}

module.exports.regUser = regUser;
module.exports.logUser = logUser;
module.exports.checkUser = checkUser;
module.exports.logout = logout;