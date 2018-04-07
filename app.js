var express=require('express');
var session=require('express-session');
var cookieParser=require('cookie-parser');
var _=require('underscore');//要使用该模块中的findWhere方法通过对象的属性值找到该对象并返回
var app=express();
var bodyParser=require('body-parser');
var urlencodedParser = bodyParser.urlencoded({ extended: false });
var crypto = require('crypto');//是使用该模块实现md5加密
app.use(express.static('public'));
app.set('views engine','ejs');
app.set('views',__dirname+'/views');
var User=require('./Dao/User');
var user=new User();
//session验证：
app.use(cookieParser());
app.use(session({
    secret:'12345',
    cookie: {maxAge: 80000000 }
}));
var allusernum=0;//存放用户的总数量
app.get('/users', function(req, res){
    if (req.session.username) {//检查用户是否已经登录
        var where;
        var mgid;
        if(req.query.mgid){
           where='mgid='+req.query.mgid;
           mgid=req.query.mgid;//如果选择了除全部用户的其它选项，需要把这个mgid存起来。分页的时候需要用到
        }
        else{
            where='';
        }
        var shownum=10;//每页显示多少数据；
        var page=req.query.page?req.query.page:1;//选中页的页码
        // console.log(page);
        var pagenum;//总页数
        var start=(page-1)*shownum;
        user.select('COUNT(uid) AS nums','users',function(data){
            // console.log(data);
            var usernum=data[0].nums;
            if(allusernum==0){
                allusernum=data[0].nums;
            }
            pagenum=Math.ceil(usernum/shownum);
            user.select('*','users',function(data){
                user.select('mgid,mgname','membergrade',function(data1){
                    var membername;
                    if(data1.length!=1){
                        membername='全部用户'
                    }else{
                        membername=data1[0].mgname
                    }
                    user.select('SUM(consume) AS totalconsume','users',function(totalconsume){
                        // console.log(totalconsume);
                        res.render('users',{
                            itemArr:data,
                            username:req.session.username,
                            shownum:shownum,
                            page:page,
                            usernum:usernum,
                            pagenum:pagenum,
                            membername:membername,
                            allusernum:allusernum,
                            mgid:mgid,
                            totalconsume:totalconsume[0].totalconsume,
                            session_username:req.session.username
                        });
                    },where)

                },where)
            },where,'uid desc',start,shownum)
        },where);
    } else {
        res.redirect('/login');
    }
});
//删除用户的路由
app.get('/userdelete',function(req,res){
    user.delete('users','uid='+req.query.uid,function(){
        res.send(true)
    })
});
//添加用户的路由
app.get('/useraddpage',function(req,res){
    if (req.session.username){
        res.render('useraddpage',{session_username:req.session.username})
    }
    else{
        res.redirect('/login');
    }
})
app.post('/useradd',urlencodedParser,function(req,res){
    user.select('tel','users',function(data){
        if(data.length!=0){
            res.send({'result':'fail'})
        }
        else{
            var regtime=getNowFormatDate();
            // console.log(regtime)
            //进行md5加密
            var md5 = crypto.createHash('md5');
            var pwd = md5.update(req.body.passwd).digest('hex');
            console.log(pwd);
            var arr=[req.body.username,pwd,req.body.tel,req.body.address,req.body.sex,regtime]
            user.insert('users','username,passwd,tel,address,sex,regtime','?,?,?,?,?,?',arr,function(){
                user.select('*','users',function(data){
                    res.send({'result':'success'})
                })
            })
        }
    },'tel='+req.body.tel)
})
//管理会员的路由
app.get('/member',function(req,res){
    if(req.session.username){
        user.select('*','membergrade',function(data){
            res.render('member',{gradeArr:data,session_username:req.session.username})
        },'mgid !=1')
    }
    else{
        res.redirect('/login');
    }
})
//实现联合菜单相应
app.post('/member',urlencodedParser,function(req,res){
    user.select('*','membergrade',function(data){
        res.send(data[0])
    },'mgid='+req.body.mgid)
})
//修改会员标准
app.post('/memberupdate',urlencodedParser,function(req,res){
        // console.log(req.body);
        user.update('membergrade','mgprice='+req.body.price+',mgdiscount='+req.body.discount,function(){
            res.send(true);
        },'mgid='+req.body.gradename)
})
//更新当前会员，该升级的升级
app.get('/memberrefresh',function(req,res){
    user.select('mgprice','membergrade',function(data){
        var mgprice=data;
        console.log(mgprice);
            user.update('users','mgid=2',function(){
                user.update('users','mgid=3',function(){
                    user.update('users','mgid=4',function(){
                        user.update('users','mgid=5',function(){
                            user.update('users','mgid=6',function(){
                                res.send(true);
                            },mgprice[5].mgprice+'<=consume')
                        },mgprice[4].mgprice+'<=consume')
                    },mgprice[3].mgprice+'<=consume')
                },mgprice[2].mgprice+'<=consume')
            },mgprice[1].mgprice+'<=consume')
    })
})
//食品：
//食品类别管理：
var cid;
app.get('/food-cate',function(req,res){
    if(req.session.username){
        if(req.query.newcatename){
            user.update('cate','catename="'+req.query.newcatename+'"',function(){
                if(req.query.catename){
                    user.insert('cate','catename','?',[req.query.catename],function(){
                        user.select('*','cate',function(data){
                            res.render('food-cate',{cateArr:data,session_username:req.session.username})
                        },'status=1')
                    })
                }
                else{
                    user.select('*','cate',function(data){
                        res.render('food-cate',{cateArr:data,session_username:req.session.username})
                    },'status=1')
                }
            },'cid='+cid)
        }
        else if(req.query.catename){
            user.insert('cate','catename','?',[req.query.catename],function(){
                user.select('*','cate',function(data){
                    res.render('food-cate',{cateArr:data,session_username:req.session.username})
                },'status=1')
            })
        }
        else{
            user.select('*','cate',function(data){
                res.render('food-cate',{cateArr:data,session_username:req.session.username})
            },'status=1')
        }
    }
    else{
        res.redirect('/login');
    }

})

app.get('/catedelete',function(req,res){
    user.delete('cate','cid='+req.query.cid,function(){
        res.send(true)
    })
})
app.get('/categet',function(req,res){
    cid=req.query.cid
    user.select('catename','cate',function(data){
        res.send(data[0].catename);
    },'cid='+req.query.cid)
})
//食物的添加：
app.get('/food-add',function(req,res){
    if(req.session.username){
        user.select('*','cate',function(data){
            res.render('food-add',{cateArr:data,session_username:req.session.username})
        })
    }
    else{
        res.redirect('/login')
    }
})
app.post('/food-add',urlencodedParser,function(req,res){
    user.select('foodname','food',function(data){
        if(!req.body.discount){
            req.body.discount=1;
        }
        var arr=[
            req.body.gradename,
            req.body.foodname,
            req.body.price,
            req.body.discount
        ]
        // console.log(req.body.discount);
        if(data.length==0){
            user.insert('food','cid,foodname,price,discount','?,?,?,?',arr,function(){
                user.update('cate','childnum=childnum+1',function(){
                    res.send(true);
                },'cid='+req.body.gradename)
            })
        }
        else{
            res.send(false);
        }
    },'status=1 AND foodname="'+req.body.foodname+'" AND cid='+req.body.gradename)
})

//食物列表的路由
app.get('/foodlist',function(req,res){
    if(req.session.username){
        user.select('catename,cid,childnum','cate',function(data){
            user.select('*','food',function(data1){
                res.render('foodlist',{cateArr:data,itemArr:data1,session_username:req.session.username});
            },'status=1')
        },'status=1')
    }
    else{
        res.redirect('/login')
    }
})

//食物查询
app.post('/foodlist',urlencodedParser,function(req,res){
    if(req.body.foodname){
        user.select('COUNT(fid) AS nums','food',function(num) {
            var shownum=5;//每页显示多少数据；
            var pagenum;//总页数
            var foodnum = num[0].nums;
            pagenum = Math.ceil(foodnum / shownum);
            var page=1;
            var start=(page-1)*shownum;
            user.select('*', 'food', function (data) {
                res.render('table-model', {
                    itemArr: data,
                    cid: req.body.cid,
                    page: page,
                    shownum: shownum,
                    pagenum:pagenum,
                    foodname:req.body.foodname
                })
            }, 'status=1 AND foodname like "%' + req.body.foodname + '%" AND cid=' + req.body.cid,'',start,shownum)
        },'status=1 AND foodname like "%' + req.body.foodname + '%" AND cid=' + req.body.cid)
    }
    var shownum=5;//每页显示多少数据；
    var pagenum;//总页数
    var page;
    if(req.body.page){
        var search=(req.body.search)?' AND foodname like "%'+req.body.search+'%"':'';
        page=req.body.page;
        var start=(page-1)*shownum;
        user.select('COUNT(fid) AS nums','food',function(data) {
            var foodnum = data[0].nums;
            pagenum = Math.ceil(foodnum / shownum);
            user.select('*','food',function(data){
                res.render('table-model',{
                    itemArr:data,
                    page:page,
                    pagenum:pagenum,
                    cid:req.body.cid,
                    foodname:req.body.search
                });
            },'status=1 AND cid='+req.body.cid+search,'',start,shownum)
        },'cid='+req.body.cid+' AND status=1'+search)
    }
})
//食物更新
app.get('/food-update',function(req,res){
    if(req.session.username){
        user.select('cid,foodname,price,discount','food',function(data){
            user.select('cid,catename','cate',function(data1){
                res.render('food-update',{cateArr:data1,item:data[0],fid:req.query.fid,session_username:req.session.username})
            },'status=1')
        },'fid='+req.query.fid)
    }
    else{
        res.redirect('/login')
    }
})
app.post('/food-update',urlencodedParser,function(req,res) {
    // console.log(req.body)
    user.select('foodname', 'food', function (data) {
        if (!req.body.discount) {
            req.body.discount = 1;
        }
        // console.log(req.body.discount);
        if (data.length == 0) {
            user.update('food', 'foodname="' + req.body.foodname + '",cid=' + req.body.gradename + ',price=' + req.body.price + ',discount=' + req.body.discount, function () {
                res.send(true);
            }, 'fid=' + req.body.fid)
        }
        else {
            res.send(false);
        }
    }, 'status=1 AND foodname="'+req.body.foodname+'" AND fid!='+req.body.fid+' AND cid='+req.body.gradename);
})
//删除食物
app.get('/food-delete',function(req,res){
    user.update('food', 'status=0', function () {
        res.send(true);
    }, 'fid=' + req.query.fid +' and status=1')
})
//当季热卖：
app.get('/food-one',function(req,res){
    user.select('*','food',function(data){
        res.render('food-one',{itemArr:data});
    },'sales>500 and status=1','sales desc')
});
//食物榜单Top10：

app.get('/food-top10',function(req,res){
    if(req.session.username){
        user.select('*','food',function(data1){
            user.select('*','food',function(data2){
                user.select('*','food',function(data3){
                    user.select('*','food',function(data4){
                        res.render('food-top10',{data1:data1,data2:data2,data3:data3,data4:data4,session_username:req.session.username})
                    },'','badnum DESC','','8')
                },'','sales','','8')
            },'','heartnum DESC','','8')
        },'','sales DESC','','8')
    }
   else{
        res.redirect('/login')
    }
})
//订单：
//订单管理
//连表查询
app.get('/order',function(req,res){
    if(req.session.username){
        user.select('orders.oid,orders.addtime,orders.content,users.username,users.tel,users.address','orders inner join users on orders.uid=users.uid',function(data){
            res.render('order',{dataArr:data,session_username:req.session.username});
        },'status=1','orders.addtime DESC')
    }
    else{
        res.redirect('/login');
    }
})

//管理员登录的路由
app.get('/login',function(req,res){
    res.render('login',{})
});
var LoginCheck=require('./Dao/LoginCheck');
var session_username;
app.post('/logincheck',urlencodedParser,function(req,res){
    var username=req.body.username;
    var passwd=req.body.passwd;
    var loginCheck=new LoginCheck();
    // console.log(req.body.username)
    loginCheck.query(username,function(data){
        if(data.length==0){
            res.send({login:'usernamefail'});
            return;
        }
        if(data[0].passwd!=passwd){
            res.send({login:'passwdfail'});
            return;
        }
        req.session.username=username;
        session_username=req.session.username;
        res.send({login:'success'});
    })
})
//注销，清除session
app.get('/clear-session',function(req,res){
    req.session.username='';
    res.redirect('/login')
})
var server=app.listen(8080);

//创建websocket对象
app.get('/socket',function(req,res){
    res.render('Socket',{})
})
var sio=require('socket.io');
var io=new sio(server);
//存放socket的数组
var hashName=new Array();
//存放用户身份的数组
var userArr=new Array();
io.on('connection',function(socket){
    // console.log(socket.id);
    var n=1;
    user.select('COUNT(oid) AS num','orders inner join users on orders.uid=users.uid',function(num){
        n=num[0].num;
        user.select('orders.addtime,users.tel','orders inner join users on orders.uid=users.uid',function(data){
            socket.emit('setmessage',{ordernum:n,ordermessage:data})
        },'status=1','addtime DESC',0,4)
    },'status=1')
    //监听用户提交订单以及后台接受订单
    socket.on('setorder',function(data){
            //判断是用户提交订单触发，还是后台接受订单触发
            if(data.isaccept){
                //接单后，重新查询一次，这样可以刷新订单的数量
                user.select('COUNT(oid) AS num','orders inner join users on orders.uid=users.uid',function(num){
                    n=num[0].num;
                    io.emit('setnewmessage',n);
                },'status=1')
            }
            else{
                //用户提交订单，重新查询一次
                user.select('COUNT(oid) AS num','orders inner join users on orders.uid=users.uid',function(num){
                    n=num[0].num;
                    io.emit('setnewmessage',n);
                },'status=1')
                io.emit('setorderlist',{});
            }
    })
    //将所有的socket都存入这个数组，这样才能实现私聊
    socket.on('getsocket',function(data){
        var name=data;
        hashName[name]=socket.id;
    })
    //监听用户发送消息
    socket.on('chatfromuser',function(data){
        var toadmin=session_username;//商家的身份
        var adminsocketid;
        //给商家发送消息
        if(adminsocketid=hashName[toadmin]){
            var adminsocket=_.findWhere(io.sockets.sockets,{id:adminsocketid});
            adminsocket.emit('toadmin',{val:data.val,time:getNowFormatDate(),tel:data.tel,photo:data.photo,userArr:userArr});
        }
    })
    socket.on('chatfromadmin',function(data){
        console.log(data)
        var touser=data.tel;//用户的身份，用手机号代替
        //给用户发送消息
        var usersocketid;
        console.log('.........')
        console.log(hashName[touser])
        if(usersocketid=hashName[touser]){
            var usersocket=_.findWhere(io.sockets.sockets,{id:usersocketid});
            usersocket.emit('touser',{val:data.val,time:getNowFormatDate(),adminname:session_username,photo:data.photo})
        }
    })
    //将新加入聊天的用户加入数组
    socket.on('addtouserArr',function(data){
        userArr.push(data);
    })
    socket.on('disconnect',function(){
        console.log(socket.id);
        console.log('--------')
        console.log(hashName[session_username])
        console.log('断开连接')
        //刷新会触发该事件
        if(hashName[session_username]==socket.id){
            userArr=[];
            console.log(hashName)
        }
    })
})
//查询数据库中的订单信息
app.get('/order-list',function(req,res) {
    if(req.session.username){
        user.select('orders.oid,orders.addtime,orders.content,users.username,users.tel,users.address','orders inner join users on orders.uid=users.uid',function(data){
            res.render('order-model', {dataArr:data,session_username:req.session.username})
        },'status=1','addtime DESC')
    }
    else{
        res.redirect('/login')
    }
})

//得到最新的四条订单，用于设置订单提醒消息
app.get('/order-message',function(req,res){
    user.select('orders.addtime,users.tel','orders inner join users on orders.uid=users.uid',function(data){
        res.render('ordermessage-model',{dataArr:data})
    },'status=1','orders.addtime DESC',0,4)
})

//接受订单
app.get('/order-accept',function(req,res){
    console.log(req.query.id)
    user.update('orders','status=0',function(){
        res.send(true);
    },'oid='+req.query.oid)
})

//用户私聊界面(管理员使用)
app.get('/chat',function(req,res){
    if(req.session.username){
        res.render('chat',{session_username:req.session.username})
    }
    else{
        res.redirect('/login')
    }
})
//用户私聊界面(用户使用)
app.get('/user-chat',function(req,res){
    res.render('user-chat',{})
})
//获取时间的函数
function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
        + " " + date.getHours() + seperator2 + date.getMinutes()
        + seperator2 + date.getSeconds();
    return currentdate;
}





//前端路由

//引入数据库写好的文件
var user1 = require('./dao1/user');


//菜单主页
app.get('/menu',function(req,res){
    var MenuDao=require('./dao1/MenuDao');
    var menuDao=new MenuDao();
    menuDao.init();
    menuDao.querycate(function(result){
        // console.log(result)
        menuDao.queryfirstdata(1,function (data) {
            res.render('menu',{menuData:data,menuList:result,session:req.session.uid,session_tel:req.session.username1});
        })
    })
})
//商品详情页面，栏目列表信息
app.get('/menuItem',function(req,res){
    var id= req.query.id;
    // console.log(id);
    //查询数据
    var MenuDao=require('./dao1/MenuDao');
    var menuDao=new MenuDao();
    menuDao.init();
    menuDao.queryItem(id,function(data){
        // console.log(data);
        res.write(JSON.stringify(data));
        res.end();
    })
})
//商品详情页，食物列表
app.get('/queryfood',function (req,res) {
    var id=req.query.id;
    var MenuDao=require('./dao1/MenuDao');
    var menuDao=new MenuDao();
    menuDao.init();
    menuDao.queryfood(id,function (data) {
        // console.log(data);
        console.log('。。。。。。。。')
        console.log(data);
        res.write(JSON.stringify(data));
        res.end();
    })
})
//商品详情页，下单，更新食品销售量
app.post('/placeAnOrder',urlencodedParser,function (req,res) {
    var orderData=JSON.parse(req.body.orderData);
    var addtime=orderData.addtime;
    var content=orderData.content;
    var price=orderData.price;
    var uid=orderData.uid;
    var foods=orderData.foods;
    // console.log('999'+foods);
    console.log('????'+uid);
    var MenuDao=require('./dao1/MenuDao');
    var menuDao=new MenuDao();
    menuDao.init();
    console.log(foods);
    menuDao.insertOrder(addtime,content,price,foods,uid,function(result){
        res.send(result);
    })
})


//任旺


app.get('/index',function (req,res) {
    //创建对象
    var User = new user1();
    //链接数据库
    User.init();
    //开始执行数据库操作
    User.spider('images','food',function (data) {
        var inforData={
            index :data
        };
        if (req.session.username1){
            res.render('index',{infor:inforData,session:req.session.username1})
        }else{
            res.render('index',{infor:inforData,session:''})
        }
    },'cid=9','',0,4)
});

app.get('/vip',function (req,res) {
    if (req.session.username1){
        var infordata = {
            user:req.session.username1
        }
        res.render('vip',{infor:infordata,flag:true,session:req.session.username1})
    }else {
        // var flag=0
        res.render('vip',{infor:'',flag:false,session:req.session.username1});
    }

});

app.post('/zhuce',urlencodedParser,function (req,res) {
    var name = req.body.nicheng;
    var md5 = crypto.createHash('md5');
    var pwd = md5.update(req.body.pwd).digest('hex');
    var tel=req.body.name;
    // console.log(pwd,typeof pwd)
    // var pwdd = ''+pwd;
    //这里使用到数据库了，哈哈
    var dao = new user1();
    dao.init();//数据库初始化，链接数据库
    //开始执行查询语句，是为了判断用户名是否被注册，
    dao.getName(tel,function (data) {
        console.log(data);
        if (data.length==0){
            //走这里表示注册的名字在数据库不存在，可以正常注册
            console.log("插入数据！！！");
            dao.insertUser('users','username,passwd,tel,regtime','?,?,?,?',[name,pwd,tel,getNowFormatDate()],function(data){
                console.log('我向数据库注册数据成功了');
                // res.write('ok');
                // res.end()
                res.write('{"flag":true}');
                res.end();
            })
        }else{
            res.write('{"flag":false}');
            res.end();
        }
    })

});


app.post('/login',urlencodedParser,function (req,res) {
    var name = req.body.name;
    var md5 = crypto.createHash('md5');
    var pwd = md5.update(req.body.pwd).digest('hex');
    console.log(name,pwd)
    //数据库开始
    var dao = new user1();
    //数据初始化：
    dao.init();
    dao.getNameName(name,pwd,function (data1) {
        if (data1.length>0 && pwd==data1[0].passwd){
            console.log('登陆正确')
            dao.query(0,'users',function (err,data) {
                var inforData={
                    user:name,
                    index :data,
                    uid:data1[0].uid
                };
                req.session.username1 = name;
                req.session.uid=data1[0].uid;
                res.send({infor:inforData});
            });
        }else {
            console.log('你登陆的数据不对');
            res.send(false)
        }
    })
});
//插入评论数据
app.post('/ordering',urlencodedParser,function (req,res) {
    var con = req.body.data;
    var date = req.body.date;
    var name = req.session.uid;
    //开始链接数据库
    var data = new user1();
    data.init();  //数据初始化，链接上数据库
    data.insertOrdering(con,date,name,function() {
        data.selectOrder(function (data1) {
            res.render('comment-model',{dataArr:data1})
        })
    })

});
//请求评论数据
app.get('/usercomments',urlencodedParser,function (req,res) {
    if (req.session.username1){
        var data = new user1();
        data.init();
        data.selectOrder(function (data) {
           console.log(data);
            res.render('comment-model',{dataArr:data})
        })
    }else{
        res.send('请登录')
    }

});
//退出登录
app.get('/out',function (req,res) {
    // console.log(req.session.username,'看看session还有没有')
    req.session.username1='';
    console.log('清除session');
    // res.render('vip',{infor:'',flag:false});
    res.redirect('/vip');
});
//个人信息栏目获取用户session。来渲染到界面上
app.get('/gerenxinxi',function (req,res) {
    res.send(req.session.username1)
});

//地址管理：把地址增加到用户的数据库里面去
app.post('/dizhi',urlencodedParser,function (req,res) {
    var sheng = req.body.sheng;
    var shi = req.body.shi;
    var qu = req.body.qu;
    var total = '"'+sheng+shi+qu+'"';
    console.log(total);
    if (req.session.username1){
        var data = new user1();
        data.init();
        data.dizhi(total,req.session.username1,function () {
            data.spider('address','users',function(data){
                res.send(data[0].address)
            },'tel='+req.session.username1)
        })
    }else{

    }


})
//把地址展示在页面上
app.get('/dizhiguanli',function (req,res) {
    if (req.session.username1){
        var data = new user1();
        data.init();
        data.dizhiZhanshi(req.session.username1,function (r) {
            console.log(r);
            res.send(r)
        })
    }
});


