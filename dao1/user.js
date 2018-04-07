/**
 * Created by Administrator on 2018/3/23 0023.
 */
function user() {
    //链接数据库
    var connection;
    this.init = function () {
        //调用mysql模块
        var mysql = require('mysql');
        //创建一个connection
        connection = mysql.createConnection({
            host: 'localhost', //主机的ip
            user: 'root',
            password: 'root',
            port: '3306',
            database: 'ours'  //数据库的表
        });
        //链接数据库
        connection.connect();
    };


    this.query = function (id, use, call) {
        var sql = 'SELECT * FROM ' + use;
        connection.query(sql, function (err, res) {
            if (!err) {
                call(err, res);
                console.log(res)
            } else {
                console.log('你哪没对');
                return;
            }
        })
    };
    this.getName = function (name, call) {
        var sql = 'select * from users where tel = "' + name + '"';
        console.log(sql);
        connection.query(sql, function (err, res) {
            if (!err) {
                console.log(res, 11);
                call(res)
            } else {
                console.log('查找用户名没搞对');
                return;
            }
        })
    };
    //登录时候的查询
    this.getNameName = function (name, pwd, call) {
        var sql = 'select * from users where tel = ' + name;
        console.log(sql);
        connection.query(sql, function (err, res) {
            if (!err) {
                call(res)
            } else {
                console.log('查找用户名没搞对');
                return;
            }
        })
    };
    //插入语句
    this.insert = function (name, passwd, tel, call) {
        console.log('执行')
        var sql = 'INSERT INTO users(username,passwd,tel) VALUES(?,?,?)';

        var sql_params = [name, passwd, tel];
        connection.query(sql, sql_params, function (err, res) {
            if (!err) {
                console.log(res)
                call();
            }
            else {
                console.log(sql_params);
            }
        })
    }
    //插入用户注册成功的数据
    this.insertUser=function(tablename,fileldname,fileldnum,filelddata,cb){
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
    //插入评论
    this.insertOrdering = function (order, date, name, call) {
        console.log('把评论内容开始插入数据库');
        var sql = 'INSERT INTO  comments(content,addtime,uid) VALUES(' + '"' + order + '","' + date + '",' + name + ')';
        console.log(sql)
        // var sqlcon = [order];
        connection.query(sql, function (err, res) {
            if (!err) {
                console.log('我成功把数据放进去了')
                call();
            } else {
                console.log('不对啊')
            }
        })
    }
    //查询评论。
    this.selectOrder = function (call) {
        var sql = 'SELECT users.tel,comments.addtime,comments.content from comments inner join users on comments.uid=users.uid where comments.status=1';
        connection.query(sql, function (err, res) {
            if (!err) {
                // console.log(res)
                call(res)
            }
        })
    }
    //管理地址，把得到的地址插入到数据库中去，
    this.dizhi = function (dizhi, username, call) {
        var sql = 'UPDATE users SET `address` = ' + dizhi + ' WHERE tel = ' + username;
        console.log(sql);
        connection.query(sql, function (err, result) {
            if (!err) {
                console.log('地址加好了')
                call()
            } else {
                console.log('地址没加好')
            }
        })
    }
    //地址管理：把地址展示在页面上
    this.dizhiZhanshi = function (username, call) {
        var sql = 'SELECT address FROM users where tel=' + username + '';
        console.log(sql);
        connection.query(sql, function (err, result) {
            if (!err) {
                console.log('找到了');
                call(result)
            }
        })
    }
    this.spider = function (filelds, tablename, cb, where, orderby, start, limit) {
        var a = arguments[3] ? arguments[3] : 1;
        var b = arguments[4] ? arguments[4] : '';
        var c = arguments[5] ? arguments[5] : 0;
        var d = arguments[6] ? arguments[6] : 0;
        var sql = 'SELECT ' + filelds + ' FROM ' + tablename + ' WHERE ' + a;
        //排序
        if (orderby) {
            sql += ' ORDER BY ' + b;
        }
        //指定查询范围
        if (limit) {
            sql += ' LIMIT ' + c + ', ' + d;
        }
        sql += ';';
        connection.query(sql, function (err, res) {
            if (!err) {
                cb(res);
            } else {
                console.log(sql);
            }
        })

    }
}

module.exports = user;