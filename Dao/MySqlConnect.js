function MySqlConnect(){
    var connection;
    this.init=function(){
       var mysql=require('mysql');
       connection=mysql.createConnection({
           host:'localhost',
           user:'root',
           password:'root',
           port:'3306',
           database:'ours'
       });
       connection.connect()
        return connection;
    }
}
module.exports=MySqlConnect;