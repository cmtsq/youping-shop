const personalDao = require('../dao/personalDao');
const cartDao = require('../dao/cartDao');
const goodsDao = require('../dao/goodsDao');
const userDao = require('../dao/userDao');
const async = require('async');

//提交订单
function confirmOrder(req,res) {
    var userID = req.session.userID;
    var goodsID = req.body.goodsID;
    var addressID = req.body.addressID;
    var order_num = parseInt(req.body.order_num);
    var order_price = parseFloat(req.body.order_price);
    //console.log(goodsID);
    //goodsID =  goodsID.split(',');
    if(addressID==undefined){
        res.send("<script>alert('请选择地址');window.location.href='/cart/showCart'</script>");
    }else{
        cartDao.selectAddress('and a.userID=? and addressID=?',[userID,addressID],(err,addressResult)=>{
            if(err){
                res.send(err.message);
            }
            personalDao.insertOrder([userID,order_num,order_price,addressResult[0].address],(err,result)=>{
                if (err){
                    return res.end(err.message);
                }
                let orderID = result;
                if(typeof goodsID == 'object'){
                    async.each(goodsID,(goodsID,callback)=>{
                        personalDao.addOrderGoods(userID,goodsID,orderID,(err,rows,fields)=>{
                            callback(err);
                        });
                    },(err)=>{
                        if(err){
                            return res.send(err.message);
                        }
                        res.send("<script>alert('订单生成成功！');window.location.href='/personal/people'</script>");
                    });
                }else{
                    personalDao.addOrderGoods(userID,goodsID,orderID,(err,rows,fields)=> {
                        if (err) {
                            return res.send(err.message);
                        }
                        res.send("<script>alert('订单生成成功！');window.location.href='/personal/people'</script>");
                    });
                }
            });
        });
    }
}
//订单显示
function showOrder(req,res) {
    var userID = req.session.userID;
    //待发货
    personalDao.selectOrderDetail('and b.userID=? and order_status="待发货"',[userID],(err,paidResult)=>{
        if(err){
            return res.end(err.message);
        }
        //待收货
        personalDao.selectOrderDetail('and b.userID=? and order_status="待收货"',[userID],(err,receivingResult)=>{
            if(err){
                return res.end(err.message);
            }
            //待评价
            personalDao.selectOrderDetail('and b.userID=? and order_status="待评价"',[userID],(err,commentResult)=>{
                if(err){
                    return res.end(err.message);
                }
                //交易完成的订单
                personalDao.selectOrderDetail('and b.userID=? and order_status="已完成"',[userID],(err,allOrderResult)=>{
                    if(err){
                        return res.end(err.message);
                    }
                    //待发货商品的数量
                    personalDao.selectOrderStatusCount('and b.userID=? and order_status="待发货"',[userID],(err,paidCount)=> {
                        if (err) {
                            return res.end(err.message);
                        }
                        //待收货商品的数量
                        personalDao.selectOrderStatusCount('and b.userID=? and order_status="待收货"',[userID],(err,receivingCount)=> {
                            if (err) {
                                return res.end(err.message);
                            }
                            //待评价商品的数量
                            personalDao.selectOrderStatusCount('and b.userID=? and order_status="待评价"',[userID],(err,commentCount)=> {
                                if (err) {
                                    return res.end(err.message);
                                }
                                //交易完成的商品数量
                                personalDao.selectOrderStatusCount('and b.userID=? and order_status="已完成"',[userID],(err,allOrderCount)=> {
                                    if (err) {
                                        return res.end(err.message);
                                    }
                                    res.render('order.html',{allOrderList:allOrderResult,commentList:commentResult,
                                        receivingList:receivingResult,paidList:paidResult,user_name:req.session.user_name,
                                    paidCount:paidCount[0],receivingCount:receivingCount[0],commentCount:commentCount[0],allOrderCount:allOrderCount[0]});
                                });
                            });
                        });
                    });
                });
            });
        });
    });
}
//个人中心显示
function showPersonalCenter(req,res){
    if(req.session.user_name){
        var userID = req.session.userID;
        //通过登录后显示用户
        userDao.selectUser('where userID=?',[userID],(err,user)=> {
            if (err) {
                res.end(err.message);
            }
            res.render('personal_center.html',{userList:user[0],user_name:req.session.user_name});
        });
    }else{
        res.send("<script>alert('请先登录');window.location.href='/user/login'</script>");
    }
}
//个人地址显示
function showAddress(req,res){
    var userID = req.session.userID;
    cartDao.selectAddress('and a.userID=?',[userID],(err,addressResult)=>{
        if(err){
            res.end(err.message);
        }
        res.render('address.html',{addressList:addressResult});
    });
}
//收藏页渲染
function showCollect(req,res){
    var userID = req.session.userID;
    personalDao.selectCollect('and a.userID=?',[userID],(err,collectResult)=>{
        if(err){
            res.end(err.message);
        }
        res.render('collect.html',{collectList:collectResult});
    });
}
//评价商品信息
function remarkGoods(req,res){
    var goodsID = req.body.commentGoodsID;
    var orderDetailID = req.body.orderDetailID;
    var userID = req.session.userID;
    var remark_content = req.body.remark_text;
    var remark_img = req.body.comment_img;
    personalDao.insertComment([goodsID,userID,remark_content,remark_img],(err,result)=>{
        if(err){
            return res.send(err.message);
        }
        //评论完完成订单交易
        personalDao.updateOrder('order_status=? where orderDetailID=?',["已完成",orderDetailID],(err,result)=>{
            if(err){
                return res.send(err.message);
            }
            res.send('<script>alert("评论成功！");window.location.href="/personal/order";waitComment();</script>');
        });
    });
}
//添加地址信息
function addAddress(req,res){
    var userID = req.session.userID;
    var name = req.body.name;
    var tel = req.body.tel;
    var address = req.body.address;
    personalDao.insertAddress([userID,name,tel,address],(err,result)=>{
        if(err){
            res.send(err.message);
        }
        res.send('<script>window.location.href="/personal/address";</script>');
    });
}
//修改地址信息
function updateAddress(req,res){
    var addressID = req.query.addressID;
    var userID = req.session.userID;
    cartDao.selectAddress('and a.userID=? and addressID=?',[userID,addressID],(err,result)=>{
        if(err){
            return res.send(err.message);
        }
        res.render('updateAddress.html',{addressResult:result[0]});
    });
}
//通过ID查询需修改的地址信息
function doUpdateAddress(req,res){
    var userID = req.session.userID;
    var addressID = req.body.addressID;
    var name = req.body.name;
    var tel = req.body.tel;
    var address = req.body.address;
    personalDao.updateAddress([name,tel,address,userID,addressID],(err,result)=>{
        if(err){
            res.send(err.message);
        }
        res.send('<script>alert("修改完成！");window.location.href="/personal/address";</script>');
    });
}
//通过ID查询需修改的地址信息
function doDelAddress(req,res){
    var userID = req.session.userID;
    var addressID = req.query.addressID;
    personalDao.delAddress([userID,addressID],(err,result)=>{
        if(err){
            res.send(err.message);
        }
        res.send('<script>alert("已删除！");window.location.href="/personal/address";</script>');
    });
}
//确认收货
function confirmReceiptGoods(req,res){
    var orderDetailID = req.query.orderDetailID;
    personalDao.updateOrder('order_status=? where orderDetailID=?',["待评价",orderDetailID],(err,result)=>{
        if(err){
            res.send(err.message);
        }
        res.send('<script>alert("已收货!");window.location.href="/personal/order";confirmReceipt();</script>');
    });
}
//我的评价
function showMyRemark(req,res){
    var userID = req.session.userID;
    goodsDao.selectRemarkByPage('and a.userID=?',[userID],(err,remark)=>{
        if(err){
            res.end(err.message);
        }
        personalDao.remarkReply('and a.userID=?',[userID],(err,remarkReplyResult)=>{
            if(err){
                res.end(err.message);
            }
            res.render('evaluate.html',{remarkList:remark,remarkReplyList:remarkReplyResult});
        });
    });
}
//删除评论
function delMyRemark(req,res){
    var remarkID = req.query.remarkID;
    personalDao.delRemark([remarkID],(err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.send('<script>alert("已删除！");window.location.href="/personal/remark"</script>');
    });
}
//个人资料
function showOneself(req,res){
    var userID = req.session.userID;
    userDao.selectUser('where userID=?',[userID],(err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.render('oneself.html',{userList:result[0]});
    });
}
//修改个人资料信息
function updateOneself(req,res){
    var userID = req.query.userID;
    userDao.selectUser('where userID=?',[userID],(err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.render('updateOneself.html',{userList:result[0]});
    });
}
function doUpdateOneself(req,res){
    var userID = req.body.userID;
    var user_head = req.body.user_head;
    var user_name = req.body.update_name;
    var user_pass = req.body.update_pass;
    userDao.updateUser([user_head,user_name,user_pass,userID],(err,result)=>{
        if(err){
            res.end(err.message);
        }
        res.send('<script>alert("修改成功,请重新登录");window.location.href="/user/login";</script>')
    });
}

module.exports.confirmOrder = confirmOrder;
module.exports.showOrder = showOrder;
module.exports.showAddress = showAddress;
module.exports.showCollect = showCollect;
module.exports.showPersonalCenter = showPersonalCenter;
module.exports.remarkGoods = remarkGoods;
module.exports.addAddress = addAddress;
module.exports.updateAddress = updateAddress;
module.exports.doDelAddress = doDelAddress;
module.exports.doUpdateAddress = doUpdateAddress;
module.exports.confirmReceiptGoods = confirmReceiptGoods;
module.exports.showMyRemark = showMyRemark;
module.exports.delMyRemark = delMyRemark;
module.exports.showOneself = showOneself;
module.exports.updateOneself = updateOneself;
module.exports.doUpdateOneself = doUpdateOneself;