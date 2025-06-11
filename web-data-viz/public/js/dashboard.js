document.addEventListener('DOMContentLoaded', function () {
    if (sessionStorage.ID_USUARIO) {
        const idUsuario = sessionStorage.ID_USUARIO;
        buscarDadosDashboard(idUsuario);
        obterDadosBarra();
        carregarPreferenciaRanking(carregarRankingGeral);
    }
});

function buscarDadosDashboard(idUsuario) {
    // Total de Pontos
    fetch(`/dashboard/total-pontos/${idUsuario}`)
        .then(response => response.json())
        .then(data => {
            document.getElementById('kpi-pontos').textContent = data.total_pontos || 0;
        })
        .catch(error => {
            console.error('Erro ao buscar pontos:', error);
            document.getElementById('kpi-pontos').textContent = 0;
        });

    // Percentual de Acertos
    fetch(`/dashboard/percentual-acertos/${idUsuario}`)
        .then(response => response.json())
        .then(data => {
            // Pega a última tentativa ou calcula a média
            const percentual = data.length > 0 ?
                data.reduce((acc, curr) => acc + parseFloat(curr.percentual), 0) / data.length : 0;
            document.getElementById('kpi-acerto').textContent = percentual.toFixed(2) + '%';
        })
        .catch(error => {
            console.error('Erro ao buscar percentual:', error);
            document.getElementById('kpi-acerto').textContent = '0%';
        });

    // Quiz com Mais Acertos
    fetch(`/dashboard/quiz-mais-acertos/${idUsuario}`)
        .then(response => response.json())
        .then(data => {
            document.getElementById('kpi-quiz').textContent = data.titulo_quiz || 'Nenhum quiz';
        })
        .catch(error => {
            console.error('Erro ao buscar quiz:', error);
            document.getElementById('kpi-quiz').textContent = 'Nenhum quiz';
        });

    // Total de Quizzes Respondidos
    fetch(`/dashboard/total-quizzes/${idUsuario}`)
        .then(response => response.json())
        .then(data => {
            document.getElementById('kpi-quizzes').textContent = data.total || 0;
        })
        .catch(error => {
            console.error('Erro ao buscar total de quizzes:', error);
            document.getElementById('kpi-quizzes').textContent = 0;
        });
}

// Gráfico de Pontos por Quiz
function obterDadosBarra() {
    const idUsuario = sessionStorage.ID_USUARIO;
    fetch(`/dashboard/pontos-por-quiz/${idUsuario}`)
        .then(response => response.json())
        .then(dados => {
            plotarGraficoBarra(dados);
        })
        .catch(err => {
            console.log(err);
        });
}

function plotarGraficoBarra(dados) {
    var pontos = [];
    var quizzes = [];
    var cores = []

    const corPorQuiz = {
        'Demacia': getComputedStyle(document.documentElement).getPropertyValue('--demacia-color'),
    'Noxus': getComputedStyle(document.documentElement).getPropertyValue('--noxus-color'),
    'Ionia': getComputedStyle(document.documentElement).getPropertyValue('--ionia-color'),
    'Freljord': getComputedStyle(document.documentElement).getPropertyValue('--freljord-color'),
    'Águas de Sentina': getComputedStyle(document.documentElement).getPropertyValue('--sentina-color'),
    'Aguas de Sentina': getComputedStyle(document.documentElement).getPropertyValue('--sentina-color'),
    'Piltover': getComputedStyle(document.documentElement).getPropertyValue('--piza-color'),
    }

    for (var i = 0; i < dados.length; i++) {
        pontos.push(dados[i].pontos);
        quizzes.push(dados[i].titulo_quiz);
        cores.push(corPorQuiz[dados[i].titulo_quiz]);
    }
    

    var ctx = document.getElementById('barra').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: quizzes,
            datasets: [{
                label: 'Pontos por Quiz',
                data: pontos,
                backgroundColor: cores,
                borderColor: cores,
                borderWidth: 1
            }]
        },
        
        options: {
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
}

// Carregar preferências de ranking do usuário
function carregarPreferenciaRanking(callback) {
    const idUsuario = sessionStorage.ID_USUARIO;
    fetch(`/usuarios/preferencia-ranking/${idUsuario}`)

        .then(res => res.json())
        .then(data => {

            const select = document.getElementById('opcao-nome-ranking');
            if (data && data.preferencia_ranking) {
                select.value = data.preferencia_ranking;
            }
            if (callback) callback();
        })
        .catch(() => {
            if (callback) callback();
        });
}

function carregarRankingGeral() {
   fetch("/dashboard/ranking-geral", {
        method: "GET",
        headers: {
            "Content-Type": "application/json"
        }
    })
    .then(function (resposta) {
        if (resposta.ok) {
            return resposta.json();
        } else {
            throw "Houve um erro ao tentar buscar o ranking geral!";
        }
    })
    .then(function (ranking) {
        exibirRanking(ranking);

        // Adicione o event listener aqui, só uma vez!
        const select = document.getElementById('opcao-nome-ranking');
        select.onchange = function() {
            const preferencia = this.value;
            const idUsuario = sessionStorage.ID_USUARIO;
            fetch(`/usuarios/preferencia-ranking/${idUsuario}`, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ preferencia })
            }).then(() => {
                // Após salvar, recarregue o ranking do back-end
                carregarRankingGeral();
            });
        };
    })
    .catch(function (erro) {
        console.log(`#ERRO: ${erro}`);
        const ul = document.getElementById('ranking-geral-list');
        ul.innerHTML = '<li>Não foi possível carregar o ranking.</li>';
    });
}

function exibirRanking(ranking) {
    const ul = document.getElementById('ranking-geral-list');
    ul.innerHTML = '';
    ranking.forEach((item, idx) => {
        ul.innerHTML += `<li>#${idx + 1} <span>${item.nome_exibicao}</span> <span>${item.total_pontos || 0} pts</span></li>`;
    });
}