CREATE DATABASE lorquiz;

USE lorquiz ;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(255) NOT NULL,
    nickname VARCHAR(100) NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
	preferencia_ranking ENUM('nick', 'nome', 'anonimo') DEFAULT 'nick'	
);

CREATE TABLE quiz (
    id_quiz INT AUTO_INCREMENT PRIMARY KEY, 
    titulo_quiz VARCHAR(255) NOT NULL,
    descricao_quiz TEXT NULL,
    nivel_dificuldade VARCHAR(10) NOT NULL, 
    total_pontos_possivel INT
);

CREATE TABLE pergunta (
    id_pergunta INT AUTO_INCREMENT, 
    id_quiz INT NOT NULL,
    pergunta varchar(100) NOT NULL UNIQUE,
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
CREATE INDEX idx_respostasusuario_usuario_quiz ON resposta_usuario(id_usuario, id_quiz);



INSERT INTO quiz (titulo_quiz, descricao_quiz, nivel_dificuldade, total_pontos_possivel) VALUES
('Demacia', 'Quiz sobre o reino de Demacia', 'Fácil', 112), -- 16 cada pergunta
('Noxu', 'Quiz sobre a história e cultura de Noxus', 'Médio', 182), -- 26 cada pergunta
('Freljord', 'Quiz sobre as tribos e lendas do Freljord', 'Difícil', 245), -- 35 cada pergunta
('Ionia', 'Quiz sobre a espiritualidade de Ionia', 'Médio', 182), -- 26 cada pergunta
('Águas de Sentina', 'Quiz sobre o submundo do crime em Águas de Sentina', 'Difícil', 245), -- 35 cada pergunta
('Piltover', 'Quiz sobre a cidade de Piltover e seus avanços tecnológicos', 'Fácil', 112); -- 16 cada pergunta

-- Demacia.
INSERT INTO pergunta (id_quiz, pergunta, alternativa_a, alternativa_b, alternativa_c, alternativa_d, alternativaCorreta) VALUES
(1, 'Quem é o rei atual de Demacia?', 'Jarvan IV', 'Garen', 'Lux', 'Vayne', 'alternativaA'),
(1, 'Qual é o lema de Demacia?', 'Força acima de tudo', 'Justiça e Honra', 'Magia e Harmonia', 'Tecnologia e Progresso', 'alternativaB'),
(1, 'Qual destes campeões NÃO é de Demacia?', 'Fiora', 'Lucian', 'Sona', 'Quinn', 'alternativaC'),
(1, 'Demacia proíbe o uso de:', 'Magia', 'Espadas', 'Escudos', 'Lanças', 'alternativaA'),
(1, 'Qual animal representa a coragem em Demacia?', 'Leão', 'Águia', 'Cavalo', 'Lobo', 'alternativaA'),
(1, 'Qual é a relação entre Garen e Lux?', 'Primos', 'Irmãos', 'Sem parentesco', 'Casados', 'alternativaB'),
(1, 'Demacia é conhecida por ser:', 'Um império expansionista', 'Uma terra de magia proibida', 'Um reino de justiça e ordem', 'Uma cidade submersa', 'alternativaC'),
(1, 'Qual destes é um valor fundamental em Demacia?', 'Honra', 'Poder', 'Riqueza', 'Conhecimento', 'alternativaA'),
(1, 'Qual destes campeões é um mago em Demacia?', 'Garen', 'Lux', 'Jarvan IV', 'Fiora', 'alternativaB'),
(1, 'Qual é a arma característica de Fiora?', 'Rapiera', 'Espada grande', 'Machado', 'Martelo', 'alternativaA'),
(1, 'Qual cor representa Demacia?', 'Azul', 'Vermelho', 'Verde', 'Roxo', 'alternativaA'),
(1, 'Qual destes elementos é mais associado a Demacia?', 'Ordem', 'Caos', 'Magia', 'Tecnologia', 'alternativaA'),
(1, 'Qual destes campeões é um exilado de Demacia?', 'Sylas', 'Shyvana', 'Xin Zhao', 'Poppy', 'alternativaA'),
(1, 'Qual é o principal inimigo histórico de Demacia?', 'Noxus', 'Freljord', 'Shurima', 'Piltover', 'alternativaA'),
(1, 'Qual é a bebida tradicional Demaciana?', 'Vinho de Mármore', 'Hidromel de Freljord', 'Cerveja Noxiana', 'Rum de Águas de Sentina', 'alternativaA');


-- Noxus
INSERT INTO pergunta (id_quiz, pergunta, alternativa_a, alternativa_b, alternativa_c, alternativa_d, alternativaCorreta) VALUES 
(2, 'Qual o símbolo máximo do poder militar de Noxus?', 'Rosa Negra', 'Muralha Imortal', 'Arena dos Desafios', 'Fortaleza de Ferro', 'alternativaB'),
(2, 'Quem fundou Noxus após a queda de um antigo império?', 'Mordekaiser', 'Sion', 'Os irmãos Darkwill', 'Os bárbaros das montanhas de Ironspike', 'alternativaD'),
(2, 'Qual facção secreta manipula eventos em Noxus?', 'Clã Du Couteau', 'Irmandade da Luz', 'Guarda Trifária', 'Rosa Negra', 'alternativaD'),
(2, 'Como Noxus trata magia e habilidades sobrenaturais?', 'Proíbe totalmente', 'Restringe a nobres', 'Encoraja como ferramenta de poder', 'Delega a Ionia', 'alternativaC'),
(2, 'Qual campeão foi um símbolo da invasão fracassada a Ionia?', 'Swain', 'Darius', 'Katarina', 'Riven', 'alternativaD'),
(2, 'Qual princípio define ascensão social em Noxus?', 'Linhagem nobre', 'Riqueza herdada', 'Mérito e força', 'Conhecimento arcano', 'alternativaC'),
(2, 'Quem governa Noxus no "Trifarix"?', 'Darius, LeBlanc e Swain', 'Swain, Darius e Draven', 'Kled, Sion e Talon', 'Vladimir, Elise e Samira', 'alternativaA'),
(2, 'Qual território Noxus NÃO conseguiu conquistar?', 'Freljord', 'Shurima', 'Demacia', 'Ionia', 'alternativaC'),
(2, 'Onde ocorrem execuções e duelos públicos em Noxus?', 'Plaza Sangrenta', 'Arena de Arenas', 'Fosso do Dragão', 'Círculo da Morte', 'alternativaC'),
(2, 'Qual campeão é conhecido como "o braço direito de Swain"?', 'Talon', 'Draven', 'Darius', 'Katarina', 'alternativaC'),
(2, 'Qual evento encerrou o reinado de Darkwill?', 'Revolução Trifária', 'Batalha do Rio Serpentine', 'Golpe do Corvo', 'Cerco de Placídia', 'alternativaC'),
(2, 'Como Noxus vê a assimilação cultural?', 'Como fraqueza', 'Como estratégia de fortalecimento', 'Como heresia', 'Como necessidade econômica', 'alternativaB'),
(2, 'Qual campeão foi ressuscitado para lutar por Noxus?', 'Vladimir', 'Sion', 'Mordekaiser', 'Kled', 'alternativaB'),
(2, 'Qual região fornece recursos mágicos para Noxus?', 'Ilha das Sombras', 'Targon', 'Águas de Sentina', 'Floresta de Kumungu', 'alternativaD'),
(2, 'Qual título Draven conquista em sua arena?', 'Campeão Supremo', 'Gladiador Imortal', 'Mestre dos Machados', 'Estrela da Morte', 'alternativaC');


-- Freljord
INSERT INTO pergunta (id_quiz, pergunta, alternativa_a, alternativa_b, alternativa_c, alternativa_d, alternativaCorreta) VALUES
(3, 'Qual é o verdadeiro propósito do Coração de Lissandra?', 'Controlar os Yetis', 'Manter o Selo de Watchers', 'Alimentar o Urso Volibear', 'Potencializar o Gelo Verdadeiro', 'alternativaB'),
(3, 'Qual evento desencadeou a Grande Divisão das tribos do Freljord?', 'Ascensão de Avarosa', 'Queda do Bastião de Gelo', 'Traição das Irmãs Gêmeas', 'Destruição do Howling Abyss', 'alternativaC'),
(3, 'Qual destes NÃO é um aspecto físico do Volibear?', 'Ruptor do Trovão', 'Mil-Passos', 'O Sem-Peixe', 'O Irrompido', 'alternativaD'),
(3, 'Como Ornn perdeu seu chifre direito?', 'Batalha contra Anivia', 'Conflito com Volibear', 'Sacrifício para selar os Watchers', 'Traição de humanos', 'alternativaB'),
(3, 'Qual é a fonte primária do poder do Gelo Verdadeiro?', 'Energia espiritual de Lissandra', 'Lágrimas de Anivia', 'Fragmentos do Vazio', 'Sangue dos Deuses Antigos', 'alternativaC'),
(3, 'O que o ritual "Tomo de Sangue" de Udyr busca controlar?', 'Espíritos do Gelo', 'Fúria do Volibear', 'Memórias de pastas vidas', 'Visões do futuro', 'alternativaC'),
(3, 'Por que os Yetis estão sendo extintos no Freljord?', 'Caça das tribos humanas', 'Maldição de Lissandra', 'Perda de sua conexão espiritual', 'Expansão do Gelo Negro', 'alternativaC'),
(3, 'Qual destes locais é um ponto focal da energia espiritual do Freljord?', 'Pico da Tempestade', 'Circulo de Gelo', 'Lágrima da Serpente', 'Coração Congelado', 'alternativaC'),
(3, 'Como Ashe se tornou a reencarnação de Avarosa?', 'Herdou o arco ancestral', 'Bebeu do Cálice de Lissandra', 'Fusão com o espírito de gelo', 'Provação no Bastião de Gelo', 'alternativaA'),
(3, 'Qual é o significado do estandarte de três garras de Sejuani?', 'Vitórias sobre os Avarosan', 'Aliança com Ursine', 'Lealdade aos Deuses Antigos', 'Conquista de três tundras', 'alternativaD'),
(3, 'O que o Olho do Twisted Treeline representa na mitologia freljordiana?', 'Queda dos Watchers', 'Último suspiro de Ornn', 'Sacrifício de Serylda', 'Nascimento de Anivia', 'alternativaA'),
(3, 'Qual tribo pratica o ritual "Amarrar a Besta Interior"?', 'Winter''s Claw', 'Frostguard', 'Avarosan', 'Irmandade de Gelo', 'alternativaB'),
(3, 'Qual destes é um título de Anivia em sua forma mortal?', 'Cryophoenix', 'Filha do Inverno', 'Guardiã do Gelo Eterno', 'Mãe das Nevascas', 'alternativaB'),
(3, 'O que desencadeou o conflito entre Gnar e os ancestrais de Tryndamere?', 'Roubo do Heartstone', 'Profanação de santuário', 'Destruição da Ponte de Gelo', 'Maldição do Yeti', 'alternativaA'),
(3, 'Qual evento marcou a transição da "Era dos Deuses" para a "Era dos Mortais"?', 'Queda do Bastião de Gelo', 'Sacrifício de Serylda', 'Julgamento das Três Irmãs', 'Renascimento de Anivia', 'alternativaC');

-- Ionia
INSERT INTO pergunta (id_quiz, pergunta, alternativa_a, alternativa_b, alternativa_c, alternativa_d, alternativaCorreta) VALUES
(4, 'Qual é o princípio fundamental que rege a magia em Ionia?', 'Harmonia com a natureza', 'Equilíbrio espiritual', 'Dominação elemental', 'Supremacia arcana', 'alternativaA'),
(4, 'Qual evento desencadeou a Primeira Guerra contra Noxus?', 'Destruição do Templo de Hirana', 'Assassinato de um embaixador noxiano', 'Invasão das Ilhas de Fae', 'Queda do Portal de Placídia', 'alternativaC'),
(4, 'Qual campeão é conhecido como "A Voz de Ionia"?', 'Irelia', 'Syndra', 'Karma', 'Ahri', 'alternativaC'),
(4, 'O que são os Vastaya em Ionia?', 'Descendentes de humanos e espíritos naturais', 'Humanos com mutações mágicas', 'Seres da natureza', 'Criaturas do Vazio', 'alternativaA'),
(4, 'Qual organização é liderada por Shen?', 'Ordem das Sombras', 'Irmandade Navori', 'Guardiões do Lótus', 'Kinkou', 'alternativaD'),
(4, 'Qual é o nome da técnica de luta com lâminas criada por Irelia?', 'Dança das Sombras', 'Corte da Fênix', 'Dança das Lâminas', 'Estilo da Raposa', 'alternativaC'),
(4, 'Onde fica o santuário espiritual mais sagrado de Ionia?', 'Floresta de Omikayalan', 'Templo do Primeiro Lótus', 'Vale do Lótus', 'Ilhas de Fae''lor', 'alternativaA'),
(4, 'Qual campeão foi responsável pela destruição do Templo de Hirana?', 'Zed', 'Jhin', 'Syndra', 'Varus', 'alternativaC'),
(4, 'Qual é o símbolo tradicional da resistência ioniana?', 'Lótus Dourado', 'Dragão Celestial', 'Fênix de Cinzas', 'Flor de Cerejeira', 'alterntivaA'),
(4, 'Qual região de Ionia é conhecida por sua rebelião contra o governo central?', 'Zhonya', 'Shon-Xan', 'Navori', 'Bahrl', 'alternativa'),
(4, 'Qual destes NÃO é um espírito guardião de Ionia?', 'Spirit of the Wilds', 'Keeper of the Gates', 'Dragon of the Falls', 'Willow of the Wisps', 'alternativaD'),
(4, 'Como Ionia reage à tecnologia hextec?', 'Vê como uma ameaça ao equilíbrio', 'Rejeita como profanação', 'Usa apenas para defesa', 'Desenvolve versões naturais', 'alternativaA'),
(4, 'Qual é a origem do poder de Ahri?', 'Gema espiritual', 'Linhagem vastaya', 'Vínculo com a lua', 'Fragmento de runa', 'alternativaB'),
(4, 'Qual evento levou à criação da Ordem das Sombras?', 'Invasão de Noxus', 'Traição de Zed', 'Queda do Templo', 'Ruptura Espiritual', 'alternativaB'),
(4, 'O que o Rio Serpentine representa na cultura ioniana?', 'Fluxo da vida', 'Ciclo de renascimento', 'Fonte de magia', 'Caminho para o além', 'alternativaA');

-- Águas de Sentina
INSERT INTO pergunta (id_quiz, pergunta, alternativa_a, alternativa_b, alternativa_c, alternativa_d, alternativaCorreta) VALUES
(5, 'Qual é o verdadeiro nome do "Terror dos Doze Mares"?', 'Gangplank', 'Rafale', 'Jagüar', 'Vinícius', 'alternativaA'),
(5, 'O que acontece com as almas que Pyke adiciona à sua "Lista"?', 'São transformadas em Dublês', 'Reencarnam como tubarões', 'Servem eternamente no navio fantasma', 'São oferecidas a Nagakabouros', 'alternativaA'),
(5, 'Qual é a origem do poder místico de Illaoi?', 'Águas Purificadas de Targon', 'Sangue do Kraken Ancestral', 'Idolo de Nagakabouros', 'Lágrimas do Deus Afogado', 'alternativaC'),
(5, 'Qual evento anual marca a chegada do Harrowing em Águas de Sentina?', 'Festa do Afogamento', 'Corte do Verão', 'Lua do Caçador', 'Maré de Sangue', 'alternativaC'),
(5, 'O que é o "Tabuleiro de Xale" em Águas de Sentina?', 'Sistema de esgotos oculto', 'Rede de contrabando de armas', 'Conselho dos Reis do Porto', 'Mapa das rotas de monstros marinhos', 'alternativaB'),
(5, 'Qual destes NÃO é um tipo de Moeda Negra?', 'Escama de Serpente', 'Dente de Kraken', 'Lágrima de Sereia', 'Olho de Tubarão', 'alternativaC'),
(5, 'Como Gangplank sobreviveu à explosão de seu navio?', 'Proteção de um feitiço de Illaoi', 'Intervenção de Nagakabouros', 'Substituição de partes do corpo por artefatos', 'Traído por Tobias Fate', 'alternativaC'),
(5, 'Qual é o segredo por trás do poder das "Pistolas de Água-Salgada"?', 'Infundidas com sangue de deus marinho', 'Forjadas em ferro fantasma', 'Corações cristalizados de krakens', 'Balas banhadas em Prata Lunar', 'alternativaD'),
(5, 'O que é o "Buraco do Túmulo" em Águas de Sentina?', 'Covil de Pyke', 'Prisão submarina', 'Cemitério de navios amaldiçoados', 'Portal para as Ilhas das Sombras', 'alternativaD'),
(5, 'Qual criatura é conhecida como "A Que Canta no Abismo"?', 'Sereia Sombria', 'Serpente das Profundezas', 'Kraken Ancestral', 'Leviatã Enlouquecido', 'alternativaA'),
(5, 'Qual é a verdadeira natureza do "Deus Afogado" adorado em Águas de Sentina?', 'Aspecto de Targon caído', 'Espectro de um rei pirata', 'Avatar de Nagakabouros', 'Máscara de Thresh', 'alternativaD'),
(5, 'O que acontece durante o "Festival do Fogo Fantasma"?', 'Sacrifício aos krakens', 'Inversão das marés', 'Queima de navios amaldiçoados', 'Libertação de espectros', 'alternativaD'),
(5, 'Qual destes locais é a fonte do poder do "Idolo de Nagakabouros"?', 'Coração do Mar Revolto', 'Olho do Tufão Eterno', 'Templo Submerso de Buhru', 'Círculo de Pedra das Ilhas Perdidas', 'alternativaC'),
(5, 'Como Miss Fortune planejou sua vingança contra Gangplank?', 'Infiltração nos Reis do Porto', 'Aliança com Pyke', 'Roubo do mapa do tesouro', 'Sabotagem do canhão do Leviathan', 'alternativaA'),
(5, 'Qual é o significado do símbolo de três gotas tatuado nos membros da "Irmandade do Mar"?', 'Lealdade, Sangue, Sal', 'Morte, Dívida, Vingança', 'Terra, Mar, Céu', 'Ferro, Fogo, Fantasma', 'alternativaB');

-- Piltover 
INSERT INTO pergunta (id_quiz, pergunta, alternativa_a, alternativa_b, alternativa_c, alternativa_d, alternativaCorreta) VALUES
(6, 'Como Piltover é conhecida em Runeterra?', 'Cidade do Progresso', 'Capital da Magia', 'Reino das Sombras', 'Terra dos Dragões', 'alternativaA'),
(6, 'Qual é o recurso tecnológico mais famoso de Piltover?', 'Hextec', 'Ferro Runico', 'Cristais Arcanos', 'Vapor Mecânico', 'alternativaA'),
(6, 'Qual evento atrai comerciantes de todo o mundo para Piltover?', 'Festival da Luz', 'Feira do Progresso', 'Torneio de Inventores', 'Grande Mercado', 'alternativaB'),
(6, 'Qual campeão é conhecido como o "Defensor de Piltover"?', 'Heimerdinger', 'Vi', 'Caitlyn', 'Jayce', 'alternativaC'),
(6, 'O que significa "Zaun" em relação a Piltover?', 'Cidade vizinha', 'Distrito nobre', 'Região subterrânea', 'Universidade', 'alternativaC'),
(6, 'Qual família é famosa por criar a tecnologia Hextec?', 'Clan Medarda', 'Família Kiramman', 'Casa Ferros', 'Dinastia Talis', 'alternativaC'),
(6, 'Qual é o nome da força policial de Piltover?', 'Defensores', 'Vigias', 'Guardiões', 'Sentinelas', 'alternativaB'),
(6, 'Onde os cientistas de Piltover realizam experimentos?', 'Torre do Relógio', 'Laboratórios da Academia', 'Oficinas do Subdistrito', 'Mercado Negro', 'alternativaB'),
(6, 'Qual campeão é uma engenheira explosiva de Piltover?', 'Seraphine', 'Orianna', 'Vi', 'Camille', 'alternativaC'),
(6, 'Qual é o principal meio de transporte em Piltover?', 'Barcos a vapor', 'Portais mágicos', 'Carruagens', 'Arcanobarcos', 'alternativaD'),
(6, 'Qual organização governa Piltover?', 'Conselho de Zaun', 'Clãs Mercantis', 'Assembleia dos Lordes', 'Conselho dos Clérigos', 'alternativaB'),
(6, 'O que a tecnologia Hextec usa como fonte de energia?', 'Cristais de Brackern', 'Lágrimas de Dragão', 'Essência Estelar', 'Núcleos Solares', 'alternativaA'),
(6, 'Qual campeão é uma inventor yordle de Piltover?', 'Teemo', 'Poppy', 'Heimerdinger', 'Rumble', 'alternativaC'),
(6, 'Qual é o nome da ponte que conecta Piltover e Zaun?', 'Ponte do Sol', 'Viaduto do Progresso', 'Passagem Solaris', 'Arco do Triunfo', 'alternativaB'),
(6, 'Qual destes NÃO é um distrito de Piltover?', 'Distrito do Relógio', 'Distrito do Comércio', 'Distrito Industrial', 'Distrito da Academia', 'alternativaC');