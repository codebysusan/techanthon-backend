var express = require('express');
const app = require('../app');
var mysqlconnect=require('../connection');
const bcrypt = require('bcryptjs');
const { hashSync, genSaltSync, compareSync } = require("bcrypt");
const jsonwebtoken = require('jsonwebtoken');
const dotenv=require('dotenv')


dotenv.config()
const getUserByEmail = (email) =>{
    return new Promise((resolve, reject)=>{
        mysqlconnect.query('SELECT * FROM User WHERE email = ? and RoleId=1', [email], (error, users)=>{
            if(error){
                return reject(error);
            }
            return resolve(users[0]);
        });
    });
};

const adminRegister=async(req,res)=>{

    try{

        const adminMall={
            email:req.body.email,
            password:req.body.password,
            UserFirstName:req.body.UserFirstName,
            UserLastName:req.body.UserLastName,
            RoleId:1,
            CreatedBy:req.body.UserFirstName + req.body.UserLastName,
            CreatedDate:new Date(),
            UpdatedBy:req.body.UserFirstName + req.body.UserLastName,
            UpdatedDate:new Date(),

        }
        const hashPassword = await bcrypt.hash(adminMall.password, 10)
        console.log(hashPassword)

        // const {name,email,contact}=req.body;
        const sqlInsert="insert into user(email,password,UserFirstName,UserLastName,RoleId,CreatedBy,CreatedDate,UpdatedBy,UpdatedDate) values(?, ?, ?,?,?,?,?,?,?)";
        mysqlconnect.query(sqlInsert,[adminMall.email,hashPassword,adminMall.UserFirstName,adminMall.UserLastName,adminMall.RoleId,adminMall.CreatedBy,adminMall.CreatedDate,adminMall.UpdatedBy,adminMall.UpdatedDate],(error,result)=>{
          if(error){
            res.status(500).json({
              message:'Error Message',
              data:error
            })
          }
          else{
        
            res.status(200).json({
              message:'Inserted Admin Data Successsfully',
              data:adminMall
            })
          }
        })
      

    }catch(error){
        console.log(error)
    }
        // 
}

const adminLogin=async(req,res)=>{
    try{
        console.log("Email")
        const login={email:req.body.email,password:req.body.password}
        console.log(login)
        if (!(login.email && login.password)) {
            res.status(201).send("All input is required");
          }
          user = await getUserByEmail(login.email);
         
          if(!user){
              return res.status(201).json({
                  message: "Invalid email"
              })
          }
       
          const isValidPassword = compareSync(login.password, user.password);
          if(isValidPassword){
            const jsontoken = jsonwebtoken.sign({user: user}, String(process.env.ADMIN_SECRET_KEY), { expiresIn: '2h'} );
            return res.status(201).json({
                message:'success',
                token:jsontoken
            })
          }
          else{
            return res.status(201).json({
                message: "Invalid email or password"
            })
          }    
      

    }catch(error){
        console.log("Error",error)
        return res.status(403).json({
        
            message: error
        })
    }
   
}


const getadminLoginDetails=async(req,res)=>{   
      try {      
      
        res.status(200).send({message:req.userData})
    } catch (error) {
        res.status(400).send({error})
    } 
}


module.exports={
    adminRegister,
    adminLogin,
    getadminLoginDetails
    
}

    
    