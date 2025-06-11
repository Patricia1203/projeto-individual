var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/total-pontos/:id_usuario", function (req, res) {
    dashboardController.totalPontosUsuario(req, res);
});

router.get("/percentual-acertos/:id_usuario", function (req, res) {
    dashboardController.percentualAcertos(req, res);
});

router.get("/quiz-mais-acertos/:id_usuario", function (req, res) {
    dashboardController.quizMaisAcertado(req, res);
});

router.get("/total-quizzes/:id_usuario", function (req, res) {
    dashboardController.totalQuizzesRespondidos(req, res);
});

router.get("/pontos-por-quiz/:id_usuario", function (req, res) {
    dashboardController.pontosPorQuizUsuario(req, res);
});

router.get("/ranking-geral", function (req, res) {
    dashboardController.rankingGeral(req, res);
});

module.exports = router;