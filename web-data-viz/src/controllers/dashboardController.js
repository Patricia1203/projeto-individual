var dashboardModel = require("../models/dashboardModel");

function totalPontosUsuario(req, res) {
    const id_usuario = req.params.id_usuario;
    dashboardModel.totalPontosUsuario(id_usuario)
        .then(resultado => {
            if (resultado.length > 0) {
                res.json(resultado[0]);
            } else {
                res.json({ total_pontos: 0 }); // Volta 0 se não houver dados
            }
        })
        .catch(erro => {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

function percentualAcertos(req, res) {
    const id_usuario = req.params.id_usuario;
    dashboardModel.percentualAcertos(id_usuario)
        .then(resultado => res.json(resultado))
        .catch(erro => {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

function quizMaisAcertado(req, res) {
    const id_usuario = req.params.id_usuario;
    dashboardModel.quizMaisAcertado(id_usuario)
        .then(resultado => res.json(resultado[0]))
        .catch(erro => {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

function totalQuizzesRespondidos(req, res) {
    const id_usuario = req.params.id_usuario;
    dashboardModel.totalQuizzesRespondidos(id_usuario)
        .then(resultado => res.json(resultado[0]))
        .catch(erro => {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

function pontosPorQuizUsuario(req, res) {
    const id_usuario = req.params.id_usuario;
    dashboardModel.pontosPorQuizUsuario(id_usuario)
        .then(resultado => res.json(resultado))
        .catch(erro => {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

function rankingGeral(req, res) {
    dashboardModel.rankingGeral()
        .then(resultado => res.json(resultado))
        .catch(erro => {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    totalPontosUsuario,
    percentualAcertos,
    quizMaisAcertado,
    totalQuizzesRespondidos,
    pontosPorQuizUsuario,
    rankingGeral
}