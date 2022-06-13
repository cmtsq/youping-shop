const sql = require('./sql');

//插入用户数据
function insertUser(params,callback) {
    var sqlStr = 'insert into t_user(userID,user_head,user_name,user_pass) values(null,?,?,?)';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        return callback(null,result);
    });
}
//查询用户数据
function selectUser(condition,params,callback) {
    var sqlStr = 'select * from t_user '+condition;
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        return callback(null,result);
    });
}
//修改个人资料
function updateUser(params,callback){
    var sqlStr = 'update t_user set user_head=?,user_name=?,user_pass=? where userID=?';
    sql.query(sqlStr,params,(err,result)=>{
        if(err){
            return callback(err,null);
        }
        return callback(null,result);
    });
}

module.exports.inserUser = insertUser;
module.exports.selectUser = selectUser;
module.exports.updateUser = updateUser;