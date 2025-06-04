function toggleMenu() {
    document.getElementById("subMenu").classList.toggle("open-menu");
}

let questaoAtual = 0;
let certas = 0;
let erradas = 0;
let totalQuestoes = listaDeQuestoes.length;

function onloadEsconder() {
    document.getElementById('jogo').style.display = "none";
    document.getElementById('pontuacao').style.display = "none";
    document.getElementById('btnTentarNovamente').style.display = "none";
    document.getElementById('btnProx').style.display = "none";
}

function embaralharQuestoes() {
    for (var i = listaDeQuestoes.length - 1; i > 0; i--) {
        var j = Math.floor(Math.random() * (i + 1));
        var temp = listaDeQuestoes[i];
        listaDeQuestoes[i] = listaDeQuestoes[j];
        listaDeQuestoes[j] = temp;
    }
}

function iniciarQuiz() {
    questaoAtual = 0;
    certas = 0;
    erradas = 0;
    embaralharQuestoes();
    document.getElementById('btnIniciarQuiz').style.display = "none";
    document.getElementById('jogo').style.display = "flex";
    document.getElementById('pontuacao').style.display = "none";
    document.getElementById('totalQuestoes').innerText = totalQuestoes;
    preencherQuestao(questaoAtual);
    document.getElementById('btnSubmeter').style.display = "block";
    document.getElementById('btnProx').style.display = "none";
    document.getElementById('btnTentarNovamente').style.display = "block";
    document.getElementById('btnVoltar1').style.display = "none";
}

function preencherQuestao(index) {
    const q = listaDeQuestoes[index];
    document.getElementById('questaoAtual').innerText = index + 1;
    document.getElementById('pergunta').innerText = q.pergunta;
    document.getElementById('labelA').innerText = q.alternativaA;
    document.getElementById('labelB').innerText = q.alternativaB;
    document.getElementById('labelC').innerText = q.alternativaC;
    document.getElementById('labelD').innerText = q.alternativaD;
    document.querySelectorAll('input[name="option"]').forEach(r => {
        r.checked = false;
        r.disabled = false;
    });
    limparCores();
    document.getElementById('btnSubmeter').style.display = "block";
    document.getElementById('btnProx').style.display = "none";
}

function submeter() {
    const options = document.getElementsByName("option");
    let checked = false, resposta = null;
    options.forEach((op) => {
        if (op.checked) {
            checked = true;
            resposta = op.value;
        }
    });
    if (!checked) {
        alert("Escolha uma opção.");
        return;
    }
    options.forEach(op => op.disabled = true);
    document.getElementById('btnSubmeter').style.display = "none";
    document.getElementById('btnProx').style.display = "block";
    checarResposta(resposta);
}

function checarResposta(resposta) {
    const correta = listaDeQuestoes[questaoAtual].alternativaCorreta;
    const labels = {
        alternativaA: 'labelA',
        alternativaB: 'labelB',
        alternativaC: 'labelC',
        alternativaD: 'labelD'
    };
    if (resposta === correta) {
        document.getElementById(labels[correta]).classList.add("text-success-with-bg");
        certas++;
    } else {
        document.getElementById(labels[resposta]).classList.add("text-danger-with-bg");
        document.getElementById(labels[correta]).classList.add("text-success-with-bg");
        erradas++;
    }
}

function avancar() {
    questaoAtual++;
    if (questaoAtual < totalQuestoes) {
        preencherQuestao(questaoAtual);
        document.getElementById('btnSubmeter').style.display = "block";
        document.getElementById('btnProx').style.display = "none";
    } else {
        finalizarQuiz();
    }
    limparCores();
}

function limparCores() {
    ['labelA', 'labelB', 'labelC', 'labelD'].forEach(id => {
        document.getElementById(id).classList.remove("text-success-with-bg", "text-danger-with-bg");
    });
}

function tentarNovamente() {
    iniciarQuiz();
}

function finalizarQuiz() {
    document.getElementById('jogo').style.display = "none";
    document.getElementById('pontuacao').style.display = "flex";
    document.querySelector('.score-container').style.display = "flex";
    document.querySelector('.score-summary').style.display = "flex";

    let pontos = certas * 100;
    document.getElementById('pontuacaoNumero').innerText = pontos;
    document.getElementById('finalCertas').innerText = certas;
    document.getElementById('finalErradas').innerText = erradas;

    let pct = Math.round((certas / totalQuestoes) * 100);
    let msg = "";
    let cls = "";
    if (pct <= 30) {
        msg = "Parece que você não estudou...";
        cls = "text-danger-with-bg";
    } else if (pct < 90) {
        msg = "Pode melhorar na próxima, hein!";
        cls = "text-warning-with-bg";
    } else {
        msg = "Uau, parabéns!";
        cls = "text-success-with-bg";
    }
    msg += `<br> Você acertou ${pct}% das questões.`;

    let msgFinal = document.getElementById('msgFinal');
    msgFinal.innerHTML = msg;
    msgFinal.className = cls;

    document.getElementById('btnTentarNovamente').style.display = "block";
    document.getElementById('btnVoltar').style.display = "block";

    // Salvar resultado no banco usando o id_quiz global
    let id_usuario = sessionStorage.ID_USUARIO;

    if (id_usuario && typeof id_quiz !== "undefined") {
        fetch("/quizzes/resultado", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ id_usuario, id_quiz, pontos })
        })
        .then(res => res.json())
        .then(data => {
            // Sucesso ao salvar resultado
            console.log("Resultado salvo!", data);
        })
        .catch(err => {
            console.error("Erro ao salvar resultado:", err);
        });
    }
}