var database = require("../database/config");


function salvarResultado(id_usuario, id_quiz, pontos) {
    // Buscar a maior tentativa já registrada do usuario para fazer o incremento de tentativas;
    var buscarTentativaSql = `
        SELECT IFNULL(MAX(tentativa), 0) AS ultimaTentativa
        FROM resposta_usuario
        WHERE id_usuario = ${id_usuario} AND id_quiz = ${id_quiz};
    `;

    return database.executar(buscarTentativaSql).then(resultado => {
        let novaTentativa = 1;
        if (resultado.length > 0) {
            novaTentativa = resultado[0].ultimaTentativa + 1;
        }
        var inserirSql = `
            INSERT INTO resposta_usuario (id_usuario, id_quiz, tentativa, pontos)
            VALUES (${id_usuario}, ${id_quiz}, ${novaTentativa}, ${pontos});
        `;
        return database.executar(inserirSql);
    });
}

module.exports = {
    salvarResultado
}
