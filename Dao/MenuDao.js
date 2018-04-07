function MenuDao(){
	var connection;
	//初始化数据库，创立数据库连接。
	this.init=function(){
		var mysql=require('mysql');
		connection=mysql.createConnection({
			host:'localhost',
			user:'root',
			password:'root',
			port:'3306',
			database:'ours'
		});
		connection.connect();
	}
    //查询菜单的列表信息
    this.querycate=function (callback) {
        var sql='select cid,catename from cate';
        connection.query(sql,function (err,result) {
            if(!err){
                callback(result);
            }else {
                console.log(err.message);
            }
        })
    }
    //页面加载时查询初始数据。
    this.queryfirstdata=function (id,callback) {
        var sql='select cate.cid,cate.catename,food.foodname,food.fid,food.images from food join cate on food.cid=cate.cid where cate.cid='+id;
        connection.query(sql,function (err,result) {
            if(!err){
                callback(result);
            }else {
                console.log(err.message);
            }
        })
    }
    //查询商品列表商品栏表和类别，对应栏目状态
	this.queryItem=function (id,callback) {
		var sql='select cate.cid,cate.catename,food.foodname,food.fid,food.images from food join cate on food.cid=cate.cid where food.cid='+id;
		connection.query(sql,function (err,result) {
			if(!err){
				callback(result);
			}else {
				console.log(err.message);
			}
        })
    }

    //查询food信息表
    this.queryfood=function(id,callback){
	    var sql='select fid,foodname,images,detail,price,sales,discount from food where fid='+id;
	    connection.query(sql,function (err,result) {
            if(!err){
                callback(result);
            }else {
                console.log(err.message);
            }
        })
    }
    
    //数据库内插入订单信息，并更新食品销售量
    this.insertOrder=function (addtime,content,price,foods,uid,call) {
        var sql='insert into orders(addtime,content,price,uid) value("'+addtime+'","'+content+'","'+price+'","'+uid+'")' ;

        connection.query(sql,function (err,res) {
            if (!err){
                console.log('数据插入成功!'+foods);
                for(var i=0;i<foods.length;i++){
                    // console.log('5555'+foods[i].fid);
                    (function (i) {
                        var sql1='UPDATE food SET sales=sales+'+foods[i].sales+' where food.fid='+foods[i].fid;
                        connection.query(sql1,function (errs,res) {
                            if(!errs){
                                console.log('食品销售量更新成功！'+sql1)
                            }else {
                                console.log('食品销售量更新失败！'+sql1)
                            }

                        })
                    })(i)

                }

            }
            else{
                console.log('数据插入失败！'+sql);
            }
        })
    }

    //更新商品销售量
    this.updateFoodTable=function (foods) {
	    for(var i=0;i<foods.length;i++){
            var sql='UPDATE food SET sales=sales+'+foods[i].sales+' where food.fid='+foods[i].fid;
            connection.query(sql,function (err,res) {
                if (!err){
                    console.log('数据更新成功!'+sql)
                }
                else{
                    console.log('数据更新失败！'+sql);
                }
            })
        }

    }

}

module.exports=MenuDao;