function toggleMenu() {
    document.getElementById("subMenu").classList.toggle("open-menu");
}

// Chama a validação de sessão ao carregar a página
window.onload = function() {
    validarSessao();
};