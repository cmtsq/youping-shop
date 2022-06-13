const adminDao = require('../dao/adminDao');
const userDao = require('../dao/userDao');
const goodsDao = require('../dao/goodsDao');
const personalDao = require('../dao/personalDao');

//解冻用户账号
function Unfreeze(req,res) {
    var userID = req.query.userID;
    adminDao.updateUser('user_status=? where userID=?',['安全',userID],(err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.send('<script>alert("该账户已解除冻结");window.location.href="/admin/admin_customer"</script>');
    });
}
//冻结用户账号
function freeze(req,res) {
    var userID = req.query.userID;
    adminDao.updateUser('user_status=? where userID=?',['冻结',userID],(err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.send('<script>alert("该账户已被冻结");window.location.href="/admin/admin_customer"</script>');
    });
}
//渲染商品管理模块
function showGoodsAdminByPage(req,res) {
    var pageSize = 6;
    var page = parseInt(req.query.page);
    adminDao.getGoodsPageCount(pageSize,(err,pageCount)=>{
        if(err){
            res.end(err.message);
        }
        adminDao.selectGoodsByPage('limit ?,?',[(page-1)*pageSize,pageSize],(err,result)=>{
            if(err){
                res.end(err.message);
            }
            adminDao.selectGoodsByPage('where goods_status=?',["下架"],(err,outAwayGoods)=>{
                if(err){
                    res.end(err.message);
                }
                res.render('admin/admin_goods.html',{pageCount:pageCount,page:page,goodsList:result,outAwayGoodsList:outAwayGoods});
            });
        });
    });
}
//模糊查询商品信息
function showGoodsSearch(req,res) {
    var searchGoodsKey = req.body.search;
    adminDao.selectGoodsByPage(`where goods_name like '%${searchGoodsKey}%'`,[],(err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.render('admin/admin_goods_search.html',{goodsList:result});
    });
}
//渲染用户管理模块
function userAdmin(req,res) {
    adminDao.selectAllUser((err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.render('admin/admin_customer.html',{customerList:result});
    });
}
//添加商品信息
function addGoods(req,res) {
    var goods_img = req.body.goods_img;
    var goods_name = req.body.goods_name;
    var goods_detail = req.body.goods_detail;
    var price_old = req.body.price_old;
    var price_new = req.body.price_new;
    var stock = req.body.stock;
    var goods_type = req.body.goods_type;
    var whether_recommend = req.body.recommend;
    adminDao.insertGoods([goods_img,goods_name,goods_detail,price_old,price_new,stock,goods_type,whether_recommend],(err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.send('<script>alert("提交成功！");window.location.href="/admin/admin_goods?page=1"</script>');
    });
}
//根据商品ID查询商品
function showGoodsByID(req,res) {
     var goodsID = req.query.goodsID;
     adminDao.selectGoodsByPage('where goodsID=?',[goodsID],(err,result)=>{
         if(err){
             res.end(err.message);
         }
         res.render('admin/admin_goods_update.html',{goodsList:result[0]});
     });
}
//修改商品信息
function doUpdateGoods(req,res) {
    var goods_img = req.body.goods_img;
    var goods_name = req.body.goods_name;
    var goods_detail = req.body.goods_detail;
    var price_old = req.body.price_old;
    var price_new = req.body.price_new;
    var stock = req.body.stock;
    var goods_type = req.body.goods_type;
    var whether_recommend = req.body.recommend;
    var goodsID = req.body.goodsID;
    adminDao.updateGoods([goods_img,goods_name,goods_detail,price_old,price_new,stock,goods_type,whether_recommend,goodsID],(err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.send('<script>alert("修改完成！");window.location.href="/admin/admin_goods?page=1"</script>');
    });
}
//上架商品
function putAwayGoods(req,res) {
    var goodsID = req.query.goodsID;
    adminDao.awayOutPutGoods(["上架",goodsID],(err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.send('<script>alert("好的，已上架！");window.location.href="/admin/admin_goods?page=1"</script>');
    });
}
//下架商品
function outAwayGoods(req,res) {
    var goodsID = req.query.goodsID;
    adminDao.awayOutPutGoods(["下架",goodsID],(err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.send('<script>alert("好的，已下架！");window.location.href="/admin/admin_goods?page=1"</script>');
    });
}
//渲染商品类型页面
function showGoodsType(req,res) {
    //查询有品众筹的数据
    goodsDao.selectGoods('and goods_type=? group by a.goodsID limit 0,3',["有品众筹"],(err,ypzcresult)=> {
        if (err) {
            res.end(err.message);
        }
        //查询有品秒杀的数据
        goodsDao.selectGoods('and goods_type=? group by a.goodsID limit 0,4', ["有品秒杀"], (err,ypmsresult) => {
            if (err) {
                res.end(err.message);
            }
            //查询每日新品的数据
            goodsDao.selectGoods('and goods_type=? group by a.goodsID limit 0,4', ["每日新品"], (err,mrxpresult) => {
                if (err) {
                    res.end(err.message);
                }
                //查询专属推荐的数据
                goodsDao.selectGoods('and goods_type=? group by a.goodsID limit 0,8', ["专属推荐"], (err,zstjresult) => {
                    if (err) {
                        res.end(err.message);
                    }
                    res.render('admin/admin_goods_type.html',{ypzcList:ypzcresult,ypmsList:ypmsresult,mrxpList:mrxpresult,zstjList:zstjresult});
                });
            });
        });
    });
}
//渲染后台首页数据统计图
function showAdminIndex(req,res) {
    adminDao.showGoodsByImg((err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.render('admin/admin_index.html',{supportList:result});
    });
}
//渲染后台
function showAdmin(req,res) {
    if(req.session.adminID){
        var adminID = req.session.adminID;
        adminDao.selectAdmin('where adminID=?',[adminID],(err,result)=>{
            if(err){
                res.end(err.message);
            }
            res.render('admin/admin.html',{admin:result[0]});
        });
    }else{
        res.redirect('/admin/admin_login');
    }
}
//后台管理员登录功能
function adminLog(req,res) {
    var admin_name = req.body.admin_name;
    var admin_pass = req.body.admin_pass;
    adminDao.selectAdmin('where admin_name=? and admin_pass=?',[admin_name,admin_pass],(err,result)=>{
        if(err){
            return res.end(err.message);
        }
        if(result.length>0){
            //将账号和管理员ID保存在session中
            req.session.adminID= result[0].adminID;
            res.send("<script>alert('欢迎登录');window.location.href='/admin/admin'</script>");
        }else{
            res.send("<script>alert('账号或者密码错误');window.location.href='/admin/admin_login'</script>");
        }
    });
}
//修改头像
function updateAdminHead(req,res){
    var adminID = req.session.adminID;
    var admin_head = req.body.admin_head_img;
    adminDao.updateAdmin('admin_head=? where adminID=?',[admin_head,adminID],(err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.send('<script>alert("修改完成");window.location.href="/admin/admin"</script>');
    });
}
//修改密码
function updateAdminPass(req,res){
    var adminID = req.session.adminID;
    var old_pass = parseInt(req.body.oldPass);
    var new_pass = parseInt(req.body.newPass);
    adminDao.selectAdmin('where adminID=?'[adminID],(err,result)=>{
        if(old_pass==result[0].admin_pass){
            adminDao.updateAdmin('admin_pass=? where adminID=?',[new_pass,adminID],(err,result)=>{
                if(err){
                    res.end(err.message);
                }
                res.send('<script>alert("修改成功，请重新登录");window.location.href="/admin/admin_login"</script>');
            });
        }else{
            res.send('<script>alert("原密码有误，请重试！");window.location.href="/admin/admin"</script>');
        }
    });

}
//渲染后台订单
function showAdminOrder(req,res){
    var pageSize = 3;
    var page = parseInt(req.query.page);
    //所有订单数
    adminDao.selectAllOrderByCount(pageSize,(err,pageCount)=>{
        if(err){
            return res.end(err.message);
        }
        //所有订单
        adminDao.selectAllOrderByPage('limit ?,?',[(page-1)*pageSize,pageSize],(err,allOrderResult)=>{
            if(err){
                res.end(err.message);
            }
            //待发货
            adminDao.selectAllOrderByPage('and order_status="待发货"',[],(err,sendGoodsResult)=>{
                if(err){
                    res.end(err.message);
                }
                //待收货
                adminDao.selectAllOrderByPage('and order_status="待收货"',[],(err,receiveGoodsResult)=>{
                    if(err){
                        res.end(err.message);
                    }
                    //已完成
                    adminDao.selectAllOrderByPage('and order_status="已完成"',[],(err,offStocksResult)=>{
                        if(err){
                            res.end(err.message);
                        }
                        res.render('admin/admin_order.html',{pageCount:pageCount,page:page,allOrderList:allOrderResult,
                            sendGoodsList:sendGoodsResult,receiveGoodsList:receiveGoodsResult,offStocksList:offStocksResult});
                    });
                });
            });
        });
    });
}
//发货处理页面渲染
function sendGoodsHandel(req,res) {
    personalDao.selectOrderDetail('and order_status="待发货"',[],(err,paidResult)=> {
        if (err) {
            return res.end(err.message);
        }
        res.render('admin/admin_sendGoodsHandel.html',{paidList:paidResult});
    });
}
//发货
function doSendGoodsHandel(req,res){
    var orderDetailID = req.query.orderDetailID;
    personalDao.updateOrder('order_status=? where orderDetailID=?',["待收货",orderDetailID],(err,result)=>{
        if(err){
            res.send(err.message);
        }
        res.send('<script>alert("已发货!");window.location.href="/admin/admin_sendHandel";</script>');
    });
}
//评价管理
function showEvaluate(req,res){
    //req.session.searchKey = null;
    var page = req.query.page;
    var pageSize = 3;
    //console.log(req.session.searchKey);
    //总页数
    goodsDao.getPageCounts(pageSize,(err,pageCount)=> {
        if (err) {
            res.end(err.message);
        }
        //按页得到评论信息
        goodsDao.selectRemarkByPage('group by remarkID limit ?,?',[(page-1)*pageSize,pageSize],(err,remark)=> {
            if (err) {
                res.end(err.message);
            }
            //查看回评
            personalDao.remarkReply('',[],(err,result)=>{
                if(err){
                    res.end(err.message);
                }
                res.render('admin/admin_evaluate.html',{pageCount:pageCount,page:parseInt(page),remarkList:remark,replyList:result});
            });
        });
    });
}
//搜索评论信息
function showSearchRemark(req,res){
    var searchKey = req.query.searchKey;
    var page = req.query.page;
    var pageSize = 3;
    goodsDao.selectRemarkByCount(`and remark_content like '%${searchKey}%'`,pageSize,(err,pageCount)=>{
        if (err) {
            res.end(err.message);
        }
        goodsDao.selectRemarkByPage(`and remark_content like '%${searchKey}%' group by remarkID limit ?,?`,[(page-1)*pageSize,pageSize],(err,remark)=>{
            if (err) {
                res.end(err.message);
            }
            req.session.searchKey = searchKey;
            res.render('admin/admin_evaluate.html',{searchList:remark,page:parseInt(page),pageCount:pageCount});
        });
    });
}
//上一页下一页
function showSearchRemark2(req,res){
    var searchKey = req.session.searchKey;
    var page = req.query.page;
    var pageSize = 3;
    //console.log(searchKey);
    goodsDao.selectRemarkByCount(`and remark_content like '%${searchKey}%'`,pageSize,(err,pageCount)=>{
        if (err) {
            res.end(err.message);
        }
        goodsDao.selectRemarkByPage(`and remark_content like '%${searchKey}%' group by remarkID limit ?,?`,[(page-1)*pageSize,pageSize],(err,remark)=>{
            if (err) {
                res.end(err.message);
            }
            res.render('admin/admin_evaluate.html',{searchList:remark,page:parseInt(page),pageCount:pageCount});
        });
    });
}
//回复评论
function doReply(req,res){
    var remarkID = req.body.remarkID;
    var reply_content = req.body.reply_content;
    adminDao.insertReply([remarkID,reply_content],(err,result)=>{
        if(err){
            res.send(err.message);
        }
        res.send("<script>alert('已回复');window.location.href='/admin/admin_evaluate?page=1'</script>");
    });
}
//删除回评
function delReply(req,res){
    var replyID = req.query.replyID;
    personalDao.delReply([replyID],(err,result)=>{
        if(err){
            res.send(err.message);
        }
        res.send('<script>alert("已删除回评！");window.location.href="/admin/admin_evaluate?page=1"</script>');
    });
}

module.exports.showAdmin = showAdmin;
module.exports.adminLog = adminLog;
module.exports.updateAdminHead = updateAdminHead;
module.exports.updateAdminPass = updateAdminPass;
module.exports.userAdmin = userAdmin;
module.exports.showGoodsAdminByPage = showGoodsAdminByPage;
module.exports.showGoodsSearch = showGoodsSearch;
module.exports.addGoods = addGoods;
module.exports.showGoodsByID = showGoodsByID;
module.exports.doUpdateGoods = doUpdateGoods;
module.exports.showGoodsType = showGoodsType;
module.exports.showAdminIndex = showAdminIndex;
module.exports.showAdminOrder = showAdminOrder;
module.exports.showEvaluate = showEvaluate;
module.exports.showSearchRemark = showSearchRemark;
module.exports.showSearchRemark2 = showSearchRemark2;
module.exports.doReply = doReply;
module.exports.sendGoodsHandel = sendGoodsHandel;
module.exports.doSendGoodsHandel = doSendGoodsHandel;
module.exports.delReply = delReply;
module.exports.Unfreeze = Unfreeze;
module.exports.freeze = freeze;
module.exports.putAwayGoods = putAwayGoods;
module.exports.outAwayGoods = outAwayGoods;