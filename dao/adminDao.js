const sql = require('./sql');

//修改用户信息
function updateUser(condition,params,callback) {
    var sqlStr = 'update t_user set '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//渲染商品管理模块,按页查询商品的信息
function selectGoodsByPage(condition,params,callback){
    var sqlStr = 'select * from t_goods '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    })
}
//得到总页数
function getGoodsPageCount(pageSize,callback) {
    var sqlStr = "select count(*) as newsCount from t_goods";
    sql.query(sqlStr,[pageSize],(err,result)=>{
        if(err){
            return callback(err,null);
        }
        var newsCount = result[0].newsCount;
        var pageCount = Math.ceil(newsCount/pageSize);
        callback(null,pageCount);
    });
}
//查询所有用户信息
function selectAllUser(callback) {
    var sqlStr = 'select * from t_user';
    sql.query(sqlStr,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//查询管理员信息
function selectAdmin(condition,params,callback) {
    var sqlStr = 'select * from t_admin '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//修改管理员信息
function updateAdmin(condition,params,callback){
    var sqlStr = 'update t_admin set '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//添加商品信息
function insertGoods(params,callback){
    var sqlStr = 'insert into t_goods(goods_img,goods_name,goods_detail,price_old,price_new,stock,goods_type,whether_recommend)' +
        ' values(?,?,?,?,?,?,?,?)';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//修改商品信息
function updateGoods(params,callback){
    var sqlStr = 'update t_goods set goods_img=?,goods_name=?,goods_detail=?,price_old=?,' +
        'price_new=?,stock=?,goods_type=?,whether_recommend=? where goodsID=?';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//上下架商品
function awayOutPutGoods(params,callback) {
    var sqlStr = 'update t_goods set goods_status=? where goodsID=?';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//查询商品信息
function showGoodsByImg(callback){
    var sqlStr = 'select * from t_goods';
    sql.query(sqlStr,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//查询所有订单条数
function selectAllOrderByCount(pageSize,callback){
    var sqlStr = 'select count(*) as newsCount from t_goods a,t_order b,t_order_detail c,t_user d ' +
        'where a.goodsID=c.goodsID and b.orderID=c.orderID and b.userID=d.userID ';
    sql.query(sqlStr,[pageSize],(err,result)=>{
        if(err){
            return callback(err,null);
        }
        var newsCount = result[0].newsCount;
        var pageCount = Math.ceil(newsCount/pageSize);
        callback(null,pageCount);
    });
}
//查询所有订单
function selectAllOrderByPage(condition,params,callback){
    var sqlStr = 'select * from t_goods a,t_order b,t_order_detail c,t_user d ' +
        'where a.goodsID=c.goodsID and b.orderID=c.orderID and b.userID=d.userID '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//回复评论
function insertReply(params,callback){
    var sqlStr = 'insert into t_reply(remarkID,reply_content) values(?,?)';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}

module.exports.selectAdmin = selectAdmin;
module.exports.updateAdmin = updateAdmin;
module.exports.selectAllUser = selectAllUser;
module.exports.getGoodsPageCount = getGoodsPageCount;
module.exports.selectGoodsByPage = selectGoodsByPage;
module.exports.updateUser = updateUser;
module.exports.insertGoods = insertGoods;
module.exports.updateGoods = updateGoods;
module.exports.updateGoods = updateGoods;
module.exports.showGoodsByImg = showGoodsByImg;
module.exports.selectAllOrderByCount = selectAllOrderByCount;
module.exports.selectAllOrderByPage = selectAllOrderByPage;
module.exports.insertReply = insertReply;
module.exports.awayOutPutGoods = awayOutPutGoods;