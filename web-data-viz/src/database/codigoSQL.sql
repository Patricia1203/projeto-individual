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

CREATE TABLE pergunta (
    id_pergunta INT AUTO_INCREMENT, 
    id_quiz INT NOT NULL,
    pergunta varchar(45) NOT NULL UNIQUE,
    alternativa_a varchar(45) NOT NULL,
    alternativa_b varchar(45) NOT NULL,
    alternativa_c varchar(45) NOT NULL,
    alternativa_d varchar(45) NOT NULL,
    alternativaCorreta varchar(45) NOT NULL,
    CONSTRAINT pkPergunta PRIMARY KEY (id_pergunta, id_quiz),
    CONSTRAINT fkPergunta_Quiz FOREIGN KEY (id_quiz) REFERENCES quiz(id_quiz)
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

INSERT INTO pergunta (id_quiz, pergunta, alternativa_a, alternativa_b, alternativa_c, alternativa_d, alternativaCorreta) VALUES
(1, 'Quem é o rei atual de Demacia?', 'Jarvan IV', 'Garen', 'Lux', 'Vayne', 'alternativaA'),
(1, 'Qual é o lema de Demacia?', 'Força acima de tudo', 'Justiça e Honra', 'Magia e Harmonia', 'Tecnologia e Progresso', 'alternativaB'),
(1, 'Qual destes campeões NÃO é de Demacia?', 'Fiora', 'Lucian', 'Sona', 'Quinn', 'alternativaC'),
(1, 'Qual é a relação entre Garen e Lux?', 'Primos', 'Irmãos', 'Sem parentesco', 'Casados', 'alternativaB'),
(1, 'Demacia é conhecida por ser:', 'Um império expansionista', 'Uma terra de magia proibida', 'Um reino de justiça e ordem', 'Uma cidade submersa', 'alternativaC'),
(1, 'Qual destes é um valor fundamental em Demacia?', 'Honra', 'Poder', 'Riqueza', 'Conhecimento', 'alternativaA'),
(1, 'Qual destes campeões é um mago em Demacia?', 'Garen', 'Lux', 'Jarvan IV', 'Fiora', 'alternativaB'),
(1, 'Qual é a arma característica de Fiora?', 'Rapiera', 'Espada grande', 'Machado', 'Martelo', 'alternativaA'),
(1, 'Qual é o nome da pedra que absorve magia em Demacia?', 'Petricita', 'Mármore', 'Quartzo', 'Diamante', 'alternativaA'),
(1, 'Qual destes elementos é mais associado a Demacia?', 'Ordem', 'Caos', 'Magia', 'Tecnologia', 'alternativaA'),
(1, 'Qual destes campeões é um exilado de Demacia?', 'Sylas', 'Shyvana', 'Xin Zhao', 'Poppy', 'alternativaA'),
(1, 'Qual é o principal inimigo histórico de Demacia?', 'Noxus', 'Freljord', 'Shurima', 'Piltover', 'alternativaA'),
(1, 'Qual é a bebida tradicional Demaciana?', 'Vinho de Mármore', 'Hidromel de Freljord', 'Cerveja Noxiana', 'Rum de Águas de Sentina', 'alternativaA');