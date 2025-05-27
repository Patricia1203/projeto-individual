// sessão
function validarSessao() {
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;

    var b_usuario = document.getElementById("b_usuario");
    var userName = document.getElementById("user-name"); // Adicione esta linha!
    var userMenu = document.getElementById("user-menu-nav");
    var loginCadastroNav = document.getElementById("login-cadastro-nav");

    if (email != null && nome != null) {
        if (b_usuario) b_usuario.innerHTML = nome;
        if (userName) userName.innerHTML = nome;
        if (userMenu) userMenu.style.display = "flex";
        if (loginCadastroNav) loginCadastroNav.style.display = "none";
    } else {
        if (userMenu) userMenu.style.display = "none";
        if (loginCadastroNav) loginCadastroNav.style.display = "flex";
        window.location = "login_cad.html?mode=login";
    }
}

function limparSessao() {
    sessionStorage.clear();
    window.location = "login_cad.html?mode=login";
}

// carregamento (loading)
function aguardar() {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "flex";
}

function finalizarAguardar(texto) {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "none";

    var divErrosLogin = document.getElementById("div_erros_login");
    if (texto) {
        divErrosLogin.style.display = "flex";
        divErrosLogin.innerHTML = texto;
    }
}

