var express = require("express");
var router = express.Router();

var quizController = require("../controllers/quizzesController");

router.post("/resultado", function (req, res) {
    quizController.salvarResultado(req, res);
});


module.exports = router;