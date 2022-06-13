const sql = require('./sql');

//删除地址信息
function delAddress(params,callback) {
    var sqlStr = 'delete from t_address where userID=? and addressID=?';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//添加地址信息
function insertAddress(params,callback) {
    var sqlStr = 'insert into t_address values(null,?,?,?,?)';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//修改地址信息
function updateAddress(params,callback) {
    var sqlStr = 'update t_address set name=?,tel=?,address=? where userID=? and addressID=?';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//订单表插入信息
function insertOrder(params,callback) {
    var sqlStr = 'insert into t_order(orderID,userID,order_num,order_price,order_address) values(null,?,?,?,?)';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result.insertId);
    });
}
//查询订单信息
function selectOrderDetail(condition,params,callback) {
    var sqlStr = 'select * from t_goods a,t_user b,t_order c,t_order_detail d ' +
        'where a.goodsID=d.goodsID and b.userID=c.userID and c.orderID=' +
        'd.orderID '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//查询我的收藏
function selectCollect(condition,params,callback){
    var sqlStr = 'select * from t_user a,t_collect b,t_goods c where a.userID=b.userID and b.goodsID=c.goodsID '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//购物车商品加入订单
function addOrderGoods(userID,goodsID,orderID,callback){
    sql.doProcedure(`call P_order(${userID},${goodsID},${orderID})`,(err,row,fields)=>{
        if(err){
            callback(err,null,null);
            return;
        }
        callback(null,row,fields);
    });
}
//插入评价信息内容
function insertComment(params,callback){
    var sqlStr = "insert into t_remark(remarkID,goodsID,userID,remark_content,remark_img) values(null,?,?,?,?)";
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//查询订单商品状态的数量
function selectOrderStatusCount(condition,params,callback){
    var sqlStr = 'select count(*) as count from t_goods a,t_user b,t_order c,t_order_detail d ' +
        'where a.goodsID=d.goodsID and b.userID=c.userID and c.orderID=' +
        'd.orderID '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//修改订单表的信息
function updateOrder(condition,params,callback){
    var sqlStr = 'update t_order_detail set '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//删除评论
function delRemark(params,callback){
    var sqlStr = 'delete from t_remark where remarkID=?';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//评论消息，回评
function remarkReply(condition,params,callback){
    var sqlStr = 'select * from t_user a,t_goods b,t_remark c,t_reply d where a.userID=c.userID' +
        ' and b.goodsID=c.goodsID and c.remarkID=d.remarkID '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//删除回评
function delReply(params,callback){
    var sqlStr = 'delete from t_reply where replyID=?';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}

module.exports.delAddress = delAddress;
module.exports.updateAddress = updateAddress;
module.exports.insertAddress = insertAddress;
module.exports.insertOrder = insertOrder;
module.exports.selectOrderDetail = selectOrderDetail;
module.exports.selectCollect = selectCollect;
module.exports.addOrderGoods = addOrderGoods;
module.exports.insertComment = insertComment;
module.exports.selectOrderStatusCount = selectOrderStatusCount;
module.exports.updateOrder = updateOrder;
module.exports.delRemark = delRemark;
module.exports.remarkReply = remarkReply;
module.exports.delReply = delReply;