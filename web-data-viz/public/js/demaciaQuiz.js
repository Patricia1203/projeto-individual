const listaDeQuestoes = [
    {
        pergunta: "Quem é o rei atual de Demacia?",
        alternativaA: "Jarvan IV",
        alternativaB: "Garen",
        alternativaC: "Lux",
        alternativaD: "Vayne",
        alternativaCorreta: "alternativaA"
    },
    {
        pergunta: "Qual é o lema de Demacia?",
        alternativaA: "Força acima de tudo",
        alternativaB: "Justiça e Honra",
        alternativaC: "Magia e Harmonia",
        alternativaD: "Tecnologia e Progresso",
        alternativaCorreta: "alternativaB"
    },
    {
        pergunta: "Qual destes campeões NÃO é de Demacia?",
        alternativaA: "Fiora",
        alternativaB: "Lucian",
        alternativaC: "Sona",
        alternativaD: "Quinn",
        alternativaCorreta: "alternativaC"
    },
    {
        pergunta: "Qual é a relação entre Garen e Lux?",
        alternativaA: "Primos",
        alternativaB: "Irmãos",
        alternativaC: "Sem parentesco",
        alternativaD: "Casados",
        alternativaCorreta: "alternativaB"
    },
    {
        pergunta: "Demacia é conhecida por ser:",
        alternativaA: "Um império expansionista",
        alternativaB: "Uma terra de magia proibida",
        alternativaC: "Um reino de justiça e ordem",
        alternativaD: "Uma cidade submersa",
        alternativaCorreta: "alternativaC"
    }
];

let questaoAtual = 0;
let certas = 0;
let erradas = 0;
let totalQuestoes = listaDeQuestoes.length;
