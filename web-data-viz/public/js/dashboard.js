document.addEventListener('DOMContentLoaded', function() {
    if (sessionStorage.ID_USUARIO) {
        const idUsuario = sessionStorage.ID_USUARIO;
        
        buscarDadosDashboard(idUsuario);
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