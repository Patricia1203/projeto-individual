CREATE DATABASE LorQuiz;

USE LorQuiz ;

CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(255) NOT NULL NOT NULL,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL, 
);

CREATE TABLE Regioes (
    id_regiao INT AUTO_INCREMENT PRIMARY KEY, 
    nome_regiao VARCHAR(100) NOT NULL UNIQUE,
    descricao_regiao TEXT NULL
);

CREATE TABLE Quizzes (
    id_quiz INT AUTO_INCREMENT PRIMARY KEY, 
    titulo_quiz VARCHAR(255) NOT NULL,
    id_regiao INT NOT NULL,
    descricao_quiz TEXT NULL,
    nivel_dificuldade VARCHAR(10) NOT NULL, 
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_regiao) REFERENCES Regioes(id_regiao)
);

CREATE TABLE Perguntas (
    id_pergunta INT AUTO_INCREMENT PRIMARY KEY, 
    texto_pergunta TEXT NOT NULL,
    pontos_dificuldade INT NOT NULL,
    alternativas_json ENUM('a', 'b', 'c', 'd') 
);

CREATE TABLE Quiz_Perguntas (
    id_quiz INT NOT NULL,
    id_pergunta INT NOT NULL,
    PRIMARY KEY (id_quiz, id_pergunta),
    FOREIGN KEY (id_quiz) REFERENCES Quizzes(id_quiz) ,
    FOREIGN KEY (id_pergunta) REFERENCES Perguntas(id_pergunta)
);

-- Respostas dos Usuários
CREATE TABLE RespostasUsuario (
    id_resposta_usuario INT AUTO_INCREMENT PRIMARY KEY, 
    id_usuario INT NOT NULL,
    id_quiz INT NOT NULL,
    id_pergunta INT NOT NULL,
    id_alternativa_escolhida VARCHAR(255) NOT NULL, 
    acertou BOOLEAN NOT NULL,
    tempo_resposta_segundos INT NULL,
    data_resposta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_quiz) REFERENCES Quizzes(id_quiz),
    FOREIGN KEY (id_pergunta) REFERENCES Perguntas(id_pergunta)
);


CREATE TABLE ProgressoUsuarioQuiz (
    id_progresso_quiz INT AUTO_INCREMENT PRIMARY KEY, 
    id_usuario INT NOT NULL,
    id_quiz INT NOT NULL,
    pontuacao_total_quiz INT DEFAULT 0, 
    perguntas_corretas_quiz INT DEFAULT 0,
    perguntas_respondidas_quiz INT DEFAULT 0,
    UNIQUE (id_usuario, id_quiz),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_quiz) REFERENCES Quizzes(id_quiz) ON DELETE CASCADE
);

CREATE INDEX idx_usuarios_email ON Usuarios(email);
CREATE INDEX idx_quizzes_id_regiao ON Quizzes(id_regiao);
CREATE INDEX idx_respostasusuario_usuario_quiz ON RespostasUsuario(id_usuario, id_quiz);
CREATE INDEX idx_progressousuarioquiz_usuario ON ProgressoUsuarioQuiz(id_usuario);