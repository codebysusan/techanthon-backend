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
        mysqlconnect.query('SELECT * FROM User WHERE email = ? and RoleId=2', [email], (error, users)=>{
            if(error){
                return reject(error);
            }
            return resolve(users[0]);
        });
    });
};

const userRegister=async(req,res)=>{

    try{

        const adminMall={
            email:req.body.email,
            password:req.body.password,
            confirmPassword:req.body.confirmPassword,
            UserFirstName:req.body.UserFirstName,
            UserLastName:req.body.UserLastName,
            RoleId:2,
            CreatedBy:req.body.UserFirstName + req.body.UserLastName,
            CreatedDate:new Date(),
            UpdatedBy:req.body.UserFirstName + req.body.UserLastName,
            UpdatedDate:new Date(),

        }
        const hashPassword = await bcrypt.hash(adminMall.password, 10)
        console.log(hashPassword)
        console.log(adminMall)
        if(adminMall.password!=adminMall.confirmPassword){
            res.status(201).json(
                {
                    message:'Password and confirm passowrd are not same'
                }
            )
        }else{
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
                  message:'Success',
                  data:adminMall
                })
              }
            })
          

        }
        // const {name,email,contact}=req.body;
       

    }catch(error){
        console.log(error)
    }
        // 
}

const userLogin=async(req,res)=>{
    try{
        console.log("Email")
        const login={email:req.body.email,password:req.body.password}
        console.log(login)
        if (!(login.email && login.password)) {
            res.status(201).json("All input is required");
          }
         
          else{
            user = await getUserByEmail(login.email);
            if(!user){
                return res.status(201).json({
                    message: "Invalid email"
                })
            }else{
              const isValidPassword = compareSync(login.password, user.password);
              if(isValidPassword){
                const jsontoken = jsonwebtoken.sign({user: user}, String(process.env.ADMIN_SECRET_KEY), { expiresIn: '12h'} );
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
            }
          }
         
         
       
         
      

    }catch(error){
        console.log("Error",error)
        return res.status(403).json({
        
            message: error
        })
    }
   
}


const getuserLoginDetails=async(req,res)=>{   
      try {      
      
        res.status(200).send({message:req.userData})
    } catch (error) {
        res.status(400).send({error})
    } 
}


module.exports={
    userRegister,
    userLogin,
    getuserLoginDetails
    
}

    
    