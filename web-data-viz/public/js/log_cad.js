function setLoginModeFromURL() {
    const params = new URLSearchParams(window.location.search);
    if (params.get('mode') === 'cadastro') {
        document.body.className = 'sign-in-js';
    } else {
        document.body.className = 'sign-up-js';
    }
}
setLoginModeFromURL();

var btnSignin = document.querySelector("#signin");
var btnSignup = document.querySelector("#signup");
btnSignin.addEventListener("click", function () {
    document.body.className = "sign-in-js";
});
btnSignup.addEventListener("click", function () {
    document.body.className = "sign-up-js";
});

document.querySelectorAll('.nav-button-box a').forEach(link => {
    link.addEventListener('click', function(e) {
        if (window.location.pathname.endsWith('login_cad.html')) {
            e.preventDefault();
            const mode = this.href.includes('mode=cadastro') ? 'sign-in-js' : 'sign-up-js';
            document.body.className = mode;
            window.history.replaceState({}, '', `login_cad.html?mode=${mode === 'sign-up-js' ? 'cadastro' : 'login'}`);
        }
    });
});

const slides = document.querySelectorAll('.slide-bg');
let current = 0;
setInterval(() => {
    slides[current].classList.remove('active');
    current = (current + 1) % slides.length;
    slides[current].classList.add('active');
}, 4000);

const senhaInput = document.getElementById('senha_input');
const strengthBar = document.getElementById('strength-bar');
const strengthText = document.getElementById('strength-text');
const passwordStrength = document.querySelector('.password-strength');

if (senhaInput) {
    senhaInput.addEventListener('focus', function () {
        passwordStrength.classList.add('active');
    });
    senhaInput.addEventListener('blur', function () {
        passwordStrength.classList.remove('active');
        strengthBar.style.background = '#333';
        strengthText.textContent = '';
    });
    senhaInput.addEventListener('input', function () {
        const val = senhaInput.value;
        let score = 0;

        if (val.length >= 8) score++;
        if (/[A-Z]/.test(val)) score++;
        if (/[a-z]/.test(val)) score++;
        if (/\d/.test(val)) score++;
        if (/[^A-Za-z0-9]/.test(val)) score++;

        let color = '#e74c3c', text = 'Fraca';
        if (score >= 4) {
            color = '#27ae60';
            text = 'Forte';
        } else if (score >= 2) {
            color = '#f1c40f';
            text = 'Média';
        }

        strengthBar.style.background = color;
        strengthText.textContent = text;
    });
}

//Login

function entrar(event) {
    if (event) event.preventDefault(); 


    var emailVar = document.getElementById('login_email_input').value;
    var senhaVar = document.getElementById('login_senha_input').value;

    if (emailVar == "" || senhaVar == "") {
        alert("Preencha todos os campos!");
        return;
    }

    fetch("/usuarios/autenticar", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            emailServer: emailVar,
            senhaServer: senhaVar
        })
    }).then(function (resposta) {
        if (resposta.ok) {
            resposta.json().then(json => {
                sessionStorage.EMAIL_USUARIO = json.email;
                sessionStorage.NOME_USUARIO = json.nome;
                sessionStorage.NICKNAME_USUARIO = json.nickname;
                sessionStorage.ID_USUARIO = json.id;
                alert("Login realizado com sucesso!");
                setTimeout(function () {
                    window.location = "quiz.html";
                }, 1000);
            });
        } else {
            resposta.text().then(texto => {
                alert(texto);
            });
        }
    }).catch(function (erro) {
        console.log(erro);
    });

    return ;
}

// Cadastro
function cadastrar() {

    //Recupere o valor da nova input pelo nome do id
    // Agora vá para o método fetch logo abaixo
    var nomeVar = nome_input.value;
    var emailVar = email_input.value;
    var nicknameVar = nickname_input.value;
    var senhaVar = senha_input.value;
    var confirmacaoSenhaVar = confirmacao_senha_input.value;


    // Verificando se há algum campo em branco
    if (
      nomeVar == "" ||
      emailVar == "" ||
      nicknameVar == "" ||
      senhaVar == "" ||
      confirmacaoSenhaVar == ""
    ) {
       alert('Mensagem de erro para todos os campos em branco');
      return;
    }

    // Verificando se a senha e a confirmação de senha são iguais
    if (senhaVar != confirmacaoSenhaVar) {
      alert('As senhas não são iguais, por favor verifique'); 

      return;
    } 


    // Enviando o valor da nova input
    fetch("/usuarios/cadastrar", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        // crie um atributo que recebe o valor recuperado aqui
        // Agora vá para o arquivo routes/usuario.js
        nomeServer: nomeVar,
        nicknameServer: nicknameVar,
        emailServer: emailVar,
        senhaServer: senhaVar,
      }),
    })
      .then(function (resposta) {
        console.log("resposta: ", resposta);

        if (resposta.ok) {

          alert("Cadastro realizado com sucesso! Redirecionando para tela de Login...");

          /* setTimeout(() => {
            window.location = "login.html";
          }, "2000"); */

        } else {
          throw "Houve um erro ao tentar realizar o cadastro!";
          alert("Houve um erro ao tentar realizar o cadastro!"); }
      })
      .catch(function (resposta) {
        console.log(`#ERRO: ${resposta}`);
      });

    return;
  }