var database = require("../database/config");

// Retorna a soma dos pontos do usuário em todos os quizzes realizados
function totalPontosUsuario(id_usuario) {
    var instrucaoSql = `
        SELECT SUM(pontos) AS total_pontos FROM resposta_usuario WHERE id_usuario = ${id_usuario};
    `;
    return database.executar(instrucaoSql);
}

// Retorna o percentual de acertos de cada tentativa realizada
function percentualAcertos(id_usuario) {
    var instrucaoSql = `
        SELECT ru.tentativa, ru.pontos, q.total_pontos_possivel, ROUND((ru.pontos / q.total_pontos_possivel) * 100, 2) AS percentual FROM resposta_usuario ru JOIN quiz q ON ru.id_quiz = q.id_quiz WHERE ru.id_usuario = ${id_usuario};
    `;
    return database.executar(instrucaoSql);
}

// Retorna a quiz que mais teve acertos das perguntas
function quizMaisAcertado(id_usuario) {
    var instrucaoSql = `
        SELECT q.titulo_quiz, SUM(ru.pontos) AS total_pontos FROM resposta_usuario ru JOIN quiz q ON ru.id_quiz = q.id_quiz WHERE ru.id_usuario = ${id_usuario} GROUP BY q.titulo_quiz ORDER BY total_pontos DESC LIMIT 1;
    `;
    return database.executar(instrucaoSql);
}

// Retorna o total de quizzes realizados pelo usuário
function totalQuizzesRespondidos(id_usuario) {
    var instrucaoSql = `
        SELECT COUNT(DISTINCT id_quiz, tentativa) AS total FROM resposta_usuario WHERE id_usuario = ${id_usuario};
    `;
    return database.executar(instrucaoSql);
}

function pontosPorQuizUsuario(id_usuario) {
    var instrucaoSql = `
        SELECT q.titulo_quiz, IFNULL(SUM(ru.pontos), 0) AS pontos FROM quiz q LEFT JOIN resposta_usuario ru ON q.id_quiz = ru.id_quiz AND ru.id_usuario = ${id_usuario} GROUP BY q.titulo_quiz ORDER BY q.titulo_quiz;
    `;
    return database.executar(instrucaoSql);
}

function rankingGeral() {
    var instrucaoSql = `
        SELECT u.id_usuario, COALESCE(u.nickname, u.nome) AS nome_exibicao, SUM(ru.pontos) AS total_pontos FROM usuario u LEFT JOIN resposta_usuario ru ON u.id_usuario = ru.id_usuario GROUP BY u.id_usuario, nome_exibicao ORDER BY total_pontos DESC;
    `;
    return database.executar(instrucaoSql);
}

module.exports = {
    totalPontosUsuario,
    percentualAcertos,
    quizMaisAcertado,
    totalQuizzesRespondidos,
    pontosPorQuizUsuario,
    rankingGeral
}