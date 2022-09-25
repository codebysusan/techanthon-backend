const { json } = require('body-parser');
var jwt=require('jsonwebtoken');
var dotenv=require('dotenv')
dotenv.config()
module.exports=(req,res,next)=>{
    try{
        
        if (typeof req.headers.authorization !== "string") {
            
            
          }
        
        var token=req.headers.authorization.split(" ")[1];
       
        console.log(token);       
        
        var decode=jwt.verify(token,process.env.ADMIN_SECRET_KEY);
        req.userData=decode;
        console.log(req.userData);
                   
        next(); 
        
    }catch(error)
    {
        console.log(error);
        res.status(401).json({
            error:"Invalid Token",
            
        });
    }

    
        
      
    
    
    
      

    
}