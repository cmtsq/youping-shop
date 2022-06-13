const sql = require('./sql');

//查询商品信息
function selectGoods(condition,params,callback) {
    var sqlStr = 'select * from t_goods a,t_picture b where a.goodsID=b.goodsID '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//查询轮播图信息
function selectPicture(callback){
    var sqlStr = 'select * from t_picture where image_type=?';
    sql.query(sqlStr,['轮播图'],(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//查询商品的评论信息
function selectRemarkByPage(condition,params,callback){
    var sqlStr = 'select * from t_user a,t_goods b,t_remark c where a.userID=c.userID and b.goodsID=c.goodsID '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//按页左连接查询评论
function leftSelectRemarkByPage(condition,params,callback) {
    var sqlStr = 'select * from t_user a LEFT JOIN t_remark b on a.userID=b.userID LEFT JOIN t_goods c on b.goodsID=c.goodsID LEFT JOIN t_reply d on b.remarkID=d.remarkID '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//得到总页数
function getPageCount(goodsId,pageSize,callback) {
    var sqlStr = "select count(*) as newsCount from t_user a,t_goods b,t_remark c where a.userID=c.userID and b.goodsID=c.goodsID and b.goodsID=?";
    sql.query(sqlStr,[goodsId,pageSize],(err,result)=>{
        if(err){
            return callback(err,null);
        }
        var newsCount = result[0].newsCount;
        var pageCount = Math.ceil(newsCount/pageSize);
        callback(null,pageCount);
    });
}
function getPageCounts(pageSize,callback) {
    var sqlStr = "select count(*) as newsCount from t_user a,t_goods b,t_remark c where a.userID=c.userID and b.goodsID=c.goodsID";
    sql.query(sqlStr,[pageSize],(err,result)=>{
        if(err){
            return callback(err,null);
        }
        var newsCount = result[0].newsCount;
        var pageCount = Math.ceil(newsCount/pageSize);
        callback(null,pageCount);
    });
}
//按搜索关键词得到评论数
function selectRemarkByCount(condition,pageSize,callback){
    var sqlStr = 'select count(*) as newsCount from t_user a,t_goods b,t_remark c where a.userID=c.userID and b.goodsID=c.goodsID '+condition;
    sql.query(sqlStr,pageSize,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        var newsCount = result[0].newsCount;
        var pageCount = Math.ceil(newsCount/pageSize);
        callback(null,pageCount);
    });
}
//根据查询条件查询商品信息
function selectSearchGoods(condition,params,callback) {
    var sqlStr = "select * from t_goods "+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    })
}
//插入收藏的商品的信息
function insertCollect(params,callback){
    var sqlStr = 'insert into t_collect values(null,?,?)';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result.insertId);
    });
}
//取消收藏
function deleteCollect(condition,params,callback){
    var sqlStr = 'delete from t_collect '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}
//根据用户ID查询收藏商品
function selectCollectByID(condition,params,callback){
    var sqlStr = 'select * from t_collect '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        callback(null,result);
    });
}

module.exports.selectCollectByID = selectCollectByID;
module.exports.selectGoods = selectGoods;
module.exports.selectPicture = selectPicture;
module.exports.selectRemarkByPage = selectRemarkByPage;
module.exports.getPageCount = getPageCount;
module.exports.selectSearchGoods = selectSearchGoods;
module.exports.insertCollect = insertCollect;
module.exports.deleteCollect = deleteCollect;
module.exports.getPageCounts = getPageCounts;
module.exports.selectRemarkByCount = selectRemarkByCount;
module.exports.leftSelectRemarkByPage = leftSelectRemarkByPage;