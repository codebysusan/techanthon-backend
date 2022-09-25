const express = require('express');
const app = require('../app');
const router = express.Router();
const mysqlconnect = require('../connection');
const { adminRegister, adminLogin, adminLoginbyEmail, getadminLoginDetails } = require('../controllers/adminController')
const { userRegister, userLogin, getuserLoginDetails } = require('../controllers/userController')
const { insertChallange, getChallangeById, deleteChallangeById, getAllChallanges, updateChallangeByUpVote, updateChallangeByDownVote } = require('../controllers/challangesController')
const authMiddleware = require('../middleware/auth')
router.get("/api/get",);
router.post("/adminuser", adminRegister)
router.post("/adminlogin", adminLogin)
router.get("/adminlogin", authMiddleware, getadminLoginDetails)

router.post("/user", userRegister)
router.post("/login", userLogin)
router.get("/login", authMiddleware, getuserLoginDetails)
// router.get("/adminemail",adminLoginbyEmail)

router.post("/challenges", authMiddleware, insertChallange)
router.delete("/challenge/:id", authMiddleware, deleteChallangeById)
router.get("/challenge/:id", authMiddleware, getChallangeById)
router.get("/challenges", authMiddleware, getAllChallanges);

router.put("/challenge/upVote/:id", authMiddleware, updateChallangeByUpVote)
router.put("/challenge/downVote/:id", authMiddleware, updateChallangeByDownVote)


module.exports = router;
