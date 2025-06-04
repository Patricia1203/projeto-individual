var quizzesModel = require("../models/quizzesModel");

function salvarResultado(req, res) {
    const { id_usuario, id_quiz, pontos } = req.body;
    if (!id_usuario || !id_quiz || pontos == undefined) {
        return res.status(400).send("Dados insuficientes para salvar resultado!");
    }
    quizzesModel.salvarResultado(id_usuario, id_quiz, pontos)
        .then(resultado => res.json(resultado))
        .catch(erro => {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}
module.exports = {
    salvarResultado
}