CREATE DATABASE lorquiz;

USE lorquiz ;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(255) NOT NULL,
    nickname VARCHAR(100) NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL
);

CREATE TABLE regiao (
    id_regiao INT AUTO_INCREMENT PRIMARY KEY, 
    nome_regiao VARCHAR(100) NOT NULL UNIQUE,
    descricao_regiao TEXT NULL
);

CREATE TABLE quiz (
    id_quiz INT AUTO_INCREMENT PRIMARY KEY, 
    titulo_quiz VARCHAR(255) NOT NULL,
    id_regiao INT NOT NULL,
    descricao_quiz TEXT NULL,
    nivel_dificuldade VARCHAR(10) NOT NULL, 
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fkQuiz_Regiao FOREIGN KEY (id_regiao) REFERENCES regiao(id_regiao)
);

CREATE TABLE resposta_usuario (
    id_usuario INT NOT NULL,
    id_quiz INT NOT NULL,
    tentativa INT NOT NULL,
    pontos INT NOT NULL,
    CONSTRAINT fkResposta_Usuario_Usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT fkResposta_Usuario_Quiz FOREIGN KEY (id_quiz) REFERENCES quiz(id_quiz),
    PRIMARY KEY (id_usuario, id_quiz, tentativa)
);


CREATE INDEX idx_usuario_email ON usuario(email);
CREATE INDEX idx_quiz_id_regiao ON quiz(id_regiao);
CREATE INDEX idx_respostasusuario_usuario_quiz ON resposta_usuario(id_usuario, id_quiz);


INSERT INTO regiao (nome_regiao, descricao_regiao) VALUES
('Demacia', 'Um reino forte e legalista com uma rica cultura militar'),
('Noxus', 'Um império expansionista que valoriza força e ambição'),
('Freljord', 'Uma terra gélida e implacável dividida por tribos em guerra'),
('Ionia', 'Uma região de beleza natural e magia espiritual'),
('Piltover', 'Uma cidade progressista que é o centro da inovação tecnológica'),
('Shurima', 'Um antigo império do deserto que está renascendo'),
('Shadow Isles', 'Uma terra amaldiçoada habitada pelos mortos-vivos');


INSERT INTO quiz (titulo_quiz, id_regiao, descricao_quiz, nivel_dificuldade) VALUES
('Demacia: Conhecimentos Gerais', 1, 'Teste seu conhecimento sobre o reino de Demacia', 'Fácil'),
('Noxus: História do Império', 2, 'Perguntas sobre a história e cultura de Noxus', 'Médio'),
('Freljord: Tribos e Lendas', 3, 'Quiz sobre as tribos e lendas do Freljord', 'Difícil'),
('Ionia: Magia e Natureza', 4, 'Conhecimentos sobre a espiritualidade de Ionia', 'Médio'),
('Piltover & Zaun: Tecnologia', 5, 'Invenções e inovação nas cidades gêmeas', 'Fácil');