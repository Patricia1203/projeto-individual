var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/total-pontos/:id_usuario", dashboardController.totalPontosUsuario);
router.get("/percentual-acertos/:id_usuario", dashboardController.percentualAcertos);
router.get("/quiz-mais-acertos/:id_usuario", dashboardController.quizMaisAcertado);
router.get("/total-quizzes/:id_usuario", dashboardController.totalQuizzesRespondidos);

module.exports = router;