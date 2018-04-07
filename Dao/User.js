var MySqlConnect=require('./MySqlConnect');
var mySqlConnect=new MySqlConnect;
var connection=mySqlConnect.init();
function User(){
    this.select=function(filelds,tablename,cb,where,orderby,start,limit){
        var a = arguments[3] ? arguments[3] : 1;
        var b = arguments[4] ? arguments[4] : '';
        var c = arguments[5] ? arguments[5] : 0;
        var d = arguments[6] ? arguments[6] : 0;
        var sql    = 'SELECT '+filelds+' FROM '+tablename+' WHERE '+a;
        //排序
        if(orderby){
            sql += ' ORDER BY ' + b;
        }
        //指定查询范围
        if(limit){
            sql += ' LIMIT ' + c + ', ' + d;
        }
        sql    += ';';
        connection.query(sql,function(err,res){
            if(!err){
                cb(res);
            }else{
                console.log(sql);
            }
        })
    }

    this.delete=function(tablename,where,cb){
        sql='DELETE FROM '+tablename+' WHERE '+where+';';
        connection.query(sql,function(err,res){
            console.log(res);
            if(!err){
                cb();
            }else{
                console.log(sql);
            }
        })
    }

    this.insert=function(tablename,fileldname,fileldnum,filelddata,cb){
        var sql='INSERT INTO '+tablename+'('+fileldname+') VALUES('+fileldnum+')';
        connection.query(sql,filelddata,function(err,res){
            if(!err){
                cb();
            }
            else{
                console.log(sql);
            }
        })
    }

    //更新
    this.update=function(tablename,set,cb,where){
        var sql='UPDATE '+tablename+' SET '+set+' WHERE ' + where;
        connection.query(sql,function(err,res){
            if(!err){
                cb();
            }
            else{
                console.log(sql);
            }
        })
    }
}
module.exports=User;