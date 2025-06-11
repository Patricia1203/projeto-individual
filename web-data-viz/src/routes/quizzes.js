var express = require("express");
var router = express.Router();

var quizController = require("../controllers/quizzesController");

router.get("/perguntas/:id_quiz", function (req, res) {
    quizController.buscarPerguntas(req, res);
});

router.post("/resultado", function (req, res) {
    quizController.salvarResultado(req, res);
});



module.exports = router;