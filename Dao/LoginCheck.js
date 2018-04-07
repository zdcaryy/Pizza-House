var MySqlConnect=require('./MySqlConnect');
var mySqlConnect=new MySqlConnect;
var connection=mySqlConnect.init();
function LoginCheck(){
    this.query=function(username,cb){
        var sql='SELECT * FROM admins where username="'+username+'"';
        connection.query(sql,function(err,res){
            if(!err){
                    cb(res);
            }else{
                console.log(sql);
            }
        })
    }
}

module.exports=LoginCheck;