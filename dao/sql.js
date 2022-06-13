const mysql = require('mysql');
module.exports.query = function (sql,values,callback) {
    var connection = mysql.createConnection({
        host:'localhost',port:3306,
        user:'root',password:'cm200225',
        database:'ypshwssc'
    });
    connection.connect((err)=>{
        if(err){
            return callback(err,null);
        }
        connection.query(sql,values,(err,result)=>{
            if(err){
                return callback(err,null);
            }
            callback(null,result);
        });
        connection.end();
    });
}
function doProcedure(proSql,callback){
    var connection = mysql.createConnection({
        host:'localhost',port:3306,
        user:'root',password:'cm200225',
        database:'ypshwssc'
    });
    connection.connect((err)=>{
        if(err){
            return callback(err,null);
        }
        connection.query(proSql,(err,row,fields)=>{
            if(err){
                return callback(err,null);
            }
            callback(null,row,fields);
        });
        connection.end();
    });
}
module.exports.doProcedure = doProcedure;