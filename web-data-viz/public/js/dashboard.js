document.addEventListener('DOMContentLoaded', function () {
    if (sessionStorage.ID_USUARIO) {
        const idUsuario = sessionStorage.ID_USUARIO;
        buscarDadosDashboard(idUsuario);
        obterDadosBarra();
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