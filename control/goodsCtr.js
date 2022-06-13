const goodsDao = require('../dao/goodsDao');
const userDao = require('../dao/userDao');

//渲染首页数据
function showIndex(req,res) {
    //查询轮播的数据
    goodsDao.selectPicture((err,carResult)=>{
        if(err){
            res.end(err.message);
        }
        //查询有品众筹的数据
        goodsDao.selectGoods('and goods_type=? and goods_status=? group by a.goodsID limit 0,3',["商品众筹","上架"],(err,ypzcresult)=>{
            if(err){
                res.end(err.message);
            }
            //查询有品秒杀的数据
            goodsDao.selectGoods('and goods_type=? and goods_status=? group by a.goodsID limit 0,5',["商品秒杀","上架"],(err,ypmsresult)=>{
                if(err){
                    res.end(err.message);
                }
                //查询每日新品的数据
                goodsDao.selectGoods('and goods_type=? and goods_status=? group by a.goodsID limit 0,5',["每日新品","上架"],(err,mrxpresult)=>{
                    if(err){
                        res.end(err.message);
                    }
                    //查询专属推荐的数据
                    goodsDao.selectGoods('and goods_type=? and goods_status=? group by a.goodsID limit 0,8',["专属推荐","上架"],(err,zstjresult)=>{
                        if(err){
                            res.end(err.message);
                        }
                        //通过登录后显示用户
                        var userID = req.session.userID;
                        userDao.selectUser('where userID=?',[userID],(err,user)=>{
                            if(err){
                                res.end(err.message);
                            }
                            res.render('index.html',{userList:user[0],zstjList:zstjresult,mrxpList:mrxpresult,
                                ypmsList:ypmsresult,ypzcList:ypzcresult,carousel:carResult,
                                user_name:req.session.user_name});
                        });
                    });
                });
            });
        });
    });
}
//渲染商品详情页面数据
function showGoodsDetail(req,res){
    var goodsId = parseInt(req.query.goodsID);
    var pageSize = 3;
    var page = parseInt(req.query.page);
    //通过登录后显示用户
    var userID = req.session.userID;
    userDao.selectUser('where userID=?',[userID],(err,user)=> {
        if (err) {
            res.end(err.message);
        }
        //详情图信息
        goodsDao.selectGoods('and a.goodsID=? and image_type=? group by pictureID',[goodsId,"详情图"],(err,detailImg)=>{
            if(err){
                res.end(err.message);
            }
            //商品详情
            goodsDao.selectGoods('and a.goodsID=? group by a.goodsID',[goodsId],(err,detail)=>{
                if(err){
                    res.end(err.message);
                }
                //描述信息
                goodsDao.selectGoods('and a.goodsID=? and image_type=? group by pictureID',[goodsId,"描述图"],(err,descImg)=>{
                    if(err){
                        res.end(err.message);
                    }
                    //总页数
                    goodsDao.getPageCount(goodsId,pageSize,(err,pageCount)=>{
                        if(err){
                            res.end(err.message);
                        }
                        //按页得到评论信息
                        goodsDao.leftSelectRemarkByPage('where c.goodsID=? group by b.remarkID limit ?,?',[goodsId,(page-1)*pageSize,pageSize],(err,remark)=>{
                            if(err){
                                res.end(err.message);
                            }
                            //相关推荐
                            var goods_type = detail[0].goods_type;
                            goodsDao.selectGoods('and goods_type=? and goods_status=? group by a.goodsID',[goods_type,"上架"],(err,recommend)=>{
                                if(err){
                                    res.end(err.message);
                                }
                                //收藏
                                goodsDao.selectCollectByID('where userID=? and goodsID=?',[userID,goodsId],(err,result)=>{
                                    if(err){
                                        res.send(err.message);
                                    }
                                    var collectGoodsID;
                                    if(result.length>0){
                                        collectGoodsID= result[0].collectID;
                                    }
                                    res.render('goods_detail.html',{collectGoodsID:collectGoodsID,goodsId:goodsId,
                                        collectID:req.session.collectID,userList:user[0],pageCount:pageCount,page:page,
                                        detail:detail[0],detailImg:detailImg,descImg:descImg,remark:remark,recommend:recommend,
                                        user_name:req.session.user_name});
                                });
                            });
                        });
                    });
                });
            });
        });
    });
}
//模糊查询商品
function showSearch(req,res){
    var searchKey = req.body.search;
    goodsDao.selectSearchGoods(`where goods_name like '%${searchKey}%'`,[],(err,searchResult)=>{
        if(err){
            res.end('err.message');
        }
        //通过登录后显示用户
        var userID = req.session.userID;
        userDao.selectUser('where userID=?',[userID],(err,user)=> {
            if (err) {
                res.end(err.message);
            }
            res.render('search.html',{userList:user[0],searchList:searchResult,user_name:req.session.user_name});
        });
    });
}
//收藏功能
function collect(req,res){
    if(req.session.user_name){
        var goodsID = req.query.detailGoodsID;
        var userID = req.session.userID;
        goodsDao.insertCollect([goodsID,userID],(err,result)=>{
            if(err){
                res.end(err.message);
            }
            res.send(`<script>alert("收藏成功");window.location.href="/goods/goods_detail?goodsID=${goodsID}&page=1"</script>`);
        });
    }else{
        res.send("<script>alert('请先登录');window.location.href='/user/login'</script>");
    }
}
//商品详情页的取消收藏
function delCollect(req,res){
    if(req.session.user_name){
        var goodsID = req.query.detailGoodsID;
        var userID = req.session.userID;
        goodsDao.deleteCollect('where goodsID=? and userID=?',[goodsID,userID],(err,result)=>{
            if(err){
                res.end(err.message);
            }
            res.send(`<script>alert("已取消收藏");window.location.href="/goods/goods_detail?goodsID=${goodsID}&page=1"</script>`);});
    }else{
        res.redirect('user/login');
    }
}
//个人中心的取消收藏
function delOneselfCollect(req,res){
    if(req.session.user_name){
        var goodsID = req.query.goodsID;
        var userID = req.session.userID;
        goodsDao.deleteCollect('where goodsID=? and userID=?',[goodsID,userID],(err,result)=>{
            if(err){
                res.end(err.message);
            }
            res.send("<script>alert('已取消收藏');window.location.href='/personal/collect';</script>");
        });
    }else{
        res.redirect('user/login');
    }
}

module.exports.showIndex = showIndex;
module.exports.showGoodsDetail = showGoodsDetail;
module.exports.showSearch = showSearch;
module.exports.collect = collect;
module.exports.delCollect = delCollect;
module.exports.delOneselfCollect = delOneselfCollect;