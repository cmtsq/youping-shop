const sql = require('./sql');

//插入商品信息到购物车
function insertCart(params,callback) {
    var sqlStr = 'insert into t_cart values(null,?,?,?)';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//查询购物车的信息
function selectCart(condition,params,callback){
    var sqlStr = 'select * from t_goods a,t_user b,t_cart c where a.goodsID=c.goodsID and b.userID=c.userID '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//修改购物车信息
function updateCart(params,callback){
    var sqlStr = 'update t_cart set goods_num=goods_num+? where goodsID=? and userID=?';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//结算时修改购物车信息
function updateCartNum(params,callback){
    var sqlStr = 'update t_cart set goods_num=? where goodsID=? and userID=?';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//删除购物车里勾选的商品
function delCartGoods(condition,params,callback){
    var sqlStr = 'delete from t_cart '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//查询地址信息
function selectAddress(condition,params,callback){
    var sqlStr = 'select * from t_user a,t_address b where a.userID=b.userID '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    })
}

module.exports.insertCart = insertCart;
module.exports.selectCart = selectCart;
module.exports.updateCart = updateCart;
module.exports.updateCartNum = updateCartNum;
module.exports.delCartGoods = delCartGoods;
module.exports.selectAddress = selectAddress;