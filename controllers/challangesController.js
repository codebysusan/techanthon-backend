var express = require('express');
const app = require('../app');
var mysqlconnect = require('../connection');

const dotenv = require('dotenv')


dotenv.config()


const insertChallange = async (req, res) => {

  try {

    const adminMall = {
      ChallangeTitle: req.body.ChallangeTitle,
      ChallangeContent: req.body.ChallangeContent,
      CreatedBy: req.userData.user.UserFirstName,
      CreatedDate: new Date(),
      UpdatedBy: req.userData.user.UserFirstName,
      UpdatedDate: new Date(),
      UserId: req.userData.user.UserId,
      UpVote: 0,
      Downvote: 0,
      RewardPoints: req.body.RewardPoints,
      Comment: null,
      UserName: req.userData.user.UserFirstName,
      status: 0

    }
    console.log(adminMall)
    // const {name,email,contact}=req.body;
    const sqlInsert = "insert into challenges(ChallangeTitle,ChallangeContent,CreatedBy,CreatedDate,UpdatedBy,UpdatedDate,UserId,UpVote,Downvote,RewardPoints,Comment,UserName,status) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
    mysqlconnect.query(sqlInsert, [adminMall.ChallangeTitle, adminMall.ChallangeContent, adminMall.CreatedBy, adminMall.CreatedDate, adminMall.UpdatedBy, adminMall.UpdatedDate, adminMall.UserId, adminMall.UpVote, adminMall.Downvote, adminMall.RewardPoints, adminMall.Comment, adminMall.UserName, adminMall.status], (error, result) => {
      if (error) {
        res.status(500).json({
          message: 'Error Message',
          data: error
        })
      }
      else {

        res.status(200).json({
          message: 'Inserted Admin Data Successsfully',
          data: adminMall
        })
      }
    })


  } catch (error) {
    console.log(error)
  }
  // 
}

const getAllChallanges = (req, res) => {

  const sqlGet = "Select * from challenges";
  mysqlconnect.query(sqlGet, (error, result) => {
    res.send(result);

  });
};

const deleteChallangeById = (req, res) => {
  const { id } = req.params;
  const sqlRemove = "delete from challenges where ChallengeId=?";
  ;
  mysqlconnect.query(sqlRemove, id, (error, result) => {
    if (error)
      console.log(error);
    else
      res.status(201).json({
        message: 'Challenge Deleted'

      })
  })
}

const getChallangeById = (req, res) => {

  const { id } = req.params;


  const sqlGet = "Select * from challenges where ChallengeId=?";
  mysqlconnect.query(sqlGet, id, (error, result) => {
    if (error) {
      console.log(error);
    }
    res.send(result);

  });
};

const updateChallangeById = (req, res) => {

  const { id } = req.params;

  const { name, email, contact } = req.body;
  const sqlUpdate = "update challenges set name=?,email=?,contact=? where id=?";

  mysqlconnect.query(sqlUpdate, [name, email, contact, id], (error, result) => {
    if (error) {
      console.log(error);
    }
    res.send(result);

  });
};

const updateChallangeByUpVote = (req, res) => {

  const { id } = req.params;

  const updateChallenge = {
    upVote: req.body.upVote
  }
  const sqlUpdate = "update challenges set upVote=? where ChallengeId=?";
  console.log(updateChallenge)
  mysqlconnect.query(sqlUpdate, [updateChallenge.upVote, id], (error, result) => {
    if (error) {
      console.log(error);
    }
    res.send(result);

  });
};

const updateChallangeByDownVote = (req, res) => {

  const { id } = req.params;

  const updateChallenge = {
    upVote: req.body.upVote
  }
  const sqlUpdate = "update challenges set upVote=? where ChallengeId=?";

  mysqlconnect.query(sqlUpdate, [updateChallenge.upVote, id], (error, result) => {
    if (error) {
      console.log(error);
    }
    res.send(result);

  });
};


module.exports = {
  updateChallangeById,
  deleteChallangeById,
  getAllChallanges,
  getChallangeById,
  insertChallange,
  updateChallangeByUpVote,
  updateChallangeByDownVote

}