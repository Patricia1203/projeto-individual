const id_quiz = 4; 
let listaDeQuestoes = [];

async function carregarQuestoes() {
    try {
        const resp = await fetch(`/quizzes/perguntas/${id_quiz}`);
    
        
        const questoesRecebidas = await resp.json();

        listaDeQuestoes = questoesRecebidas.map(q => ({
            pergunta: q.pergunta,
            alternativaA: q.alternativa_a,
            alternativaB: q.alternativa_b,
            alternativaC: q.alternativa_c,
            alternativaD: q.alternativa_d,
            alternativaCorreta: q.alternativaCorreta
        }));

        totalQuestoes = listaDeQuestoes.length;
        if (totalQuestoes === 0) {
            console.log("Nenhuma questão encontrada para o quiz.");

        } else {
            iniciarQuiz(); 
        }

    } catch (error) {
        console.error("Falha ao carregar as questões:", error);
    }
}

