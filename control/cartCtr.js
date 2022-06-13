const cartDao = require('../dao/cartDao');
const userDao = require('../dao/userDao');
const goodsDao = require('../dao/goodsDao');
const async = require('async');

//渲染购物车页面
function showCart(req,res) {
    if(req.session.user_name){
        var userID = req.session.userID;
        cartDao.selectCart('and c.userID=?',[userID],(err,result)=> {
            if (err) {
                return res.end(err.message);
            }
            //通过登录后显示用户
            userDao.selectUser('where userID=?',[userID],(err,user)=> {
                if (err) {
                    res.end(err.message);
                }
                res.render('shopping_cart.html', {userList:user[0],cartList:result,user_name:req.session.user_name});
            });
        });
    }else{
        res.send("<script>alert('请先登录');window.location.href='/user/login'</script>");
    }
}
//添加商品到购物车
function addGoodsToCart(req,res) {
    if(req.session.user_name){
        var goodsID = req.body.goodsID;
        var userID = req.session.userID;
        var goods_num = req.body.number;

        cartDao.selectCart('and b.userID=? and a.goodsID=?',[userID,goodsID],(err,result)=>{
            if(err){
                res.end(err.message);
            }
            if(result.length>0){
                cartDao.updateCart([goods_num,goodsID,userID],(err,result)=>{
                    if (err){
                        return res.end(err.message);
                    }
                    res.send("<script>alert('添加成功!');window.location.href='/cart/showCart'</script>");
                });
            }else{
                cartDao.insertCart([goodsID,userID,goods_num],(err,result)=>{
                    if(err){
                        return res.end(err.message);
                    }
                    res.send("<script>alert('添加成功');window.location.href='/cart/showCart'</script>");
                });
            }
        });
    }else{
        res.send("<script>alert('请先登录');window.location.href='/user/login'</script>");
    }
}
//删除商品
function delCartGoods(req,res) {
    var goodsID = req.query.goodsID;
    cartDao.delCartGoods('where goodsID=?',[goodsID],(err,result)=>{
        if(err){
            return res.send(err.message);
        }
        res.send('<script>alert("删除成功！");window.location.href="/cart/showCart"</script>');
    });
}
//删除所勾选的商品
function delCheckGoods(req,res) {
    var checkGoods = req.body.checkGoods;
    if(checkGoods==undefined){
        res.send("<script>alert('没有商品可删除');window.location.href='/cart/showCart'</script>");
    }else{
        async.each(checkGoods,(goodsID,callback)=>{
            cartDao.delCartGoods('where goodsID=?',[goodsID],(err,result)=>{
                callback(err);
            });
        },(err)=>{
            if(err){
                return res.send(err.message);
            }
            res.send('<script>alert("删除成功");window.location.href="/cart/showCart"</script>');
        });
    }
}
//去结算
function toSettle(req,res){
    var checkGoods = req.body.checkGoods;
    var userID = req.session.userID;
    var goodsId = req.body.cartGoodsID;
    var goodsNum = req.body.goodsNum;
    var result = [];
    if(checkGoods==undefined){
        res.send("<script>window.location.href='/cart/showCart'</script>");
    }else{
        if(typeof checkGoods == "object"){
            userDao.selectUser('where userID=?',[userID],(err,user)=> {
                if (err) {
                    res.end(err.message);
                }
                cartDao.selectAddress('and a.userID=?',[userID],(err,addressResult)=>{
                    if(err){
                        return res.send(err.message);
                    }
                    async.each(checkGoods,(goodsID,callback)=>{
                        cartDao.selectCart('and a.goodsID=?',[goodsID],(err,cartResult)=>{
                            result.push(cartResult[0]);
                            callback(err);
                        });
                    },(err)=>{
                        if(err){
                            return res.send(err.message);
                        }
                        res.render('place_order.html',{addressList:addressResult,cartGoods:result,userList:user[0],
                            user_name:req.session.user_name,userID:req.session.userID});
                    });
                });
            });
        }else{
            userDao.selectUser('where userID=?',[userID],(err,user)=> {
                if (err) {
                    res.end(err.message);
                }
                cartDao.selectAddress('and a.userID=?',[userID],(err,addressResult)=>{
                    if(err){
                        return res.send(err.message);
                    }
                    cartDao.updateCartNum([goodsNum,goodsId,userID],(err,result)=>{
                        if(err){
                            return res.send(err.message);
                        }
                        cartDao.selectCart('and a.goodsID=?',[checkGoods],(err,cartResult)=>{
                            if(err){
                                return res.send(err.message);
                            }
                            res.render('place_order.html',{addressList:addressResult,cartGoods:cartResult,
                                userList:user[0],user_name:req.session.user_name,userID:req.session.userID});
                        });
                    });
                });
            });
        }
    }
}
//增加商品数量
function updateAddNum(req,res) {
    var userID = req.session.userID;
    var goodsId = req.body.cartGoodsID;
    var goodsNum = parseInt(req.body.goodsNum);
    cartDao.updateCartNum([goodsNum+1,goodsId,userID],(err,updateResult)=> {
        if (err) {
            return res.send(err.message);
        }
        res.send({updateAddResult:updateResult});
    });
}
//减少商品数量
function updateSubNum(req,res) {
    var userID = req.session.userID;
    var goodsId = req.body.cartGoodsID;
    var goodsNum = parseInt(req.body.goodsNum);
    cartDao.updateCartNum([goodsNum-1,goodsId,userID],(err,updateResult)=> {
        if (err) {
            return res.send(err.message);
        }
        res.send({updateSubResult:updateResult});
    });
}

module.exports.updateAddNum = updateAddNum;
module.exports.updateSubNum = updateSubNum;
module.exports.showCart = showCart;
module.exports.addGoodsToCart = addGoodsToCart;
module.exports.delCheckGoods = delCheckGoods;
module.exports.delCartGoods = delCartGoods;
module.exports.toSettle = toSettle;