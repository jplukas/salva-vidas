function atualiza(interf, data) {
    interf.pontos.text(data.pontos + (Math.abs(data.pontos) > 1 ? ' pontos' : ' ponto'));
    interf.meu_voto.text(data.voto == +1 ? 'Gostei' : (data.voto == -1 ? 'Não gostei' : ''));
    interf.up.html('<img src="/assets/' + (data.voto == +1 ? 'up-ativo' : 'up-inativo') + '.png">');
    interf.down.html('<img src="/assets/' + (data.voto == -1 ? 'down-ativo' : 'down-inativo') + '.png">');
}

function cliqueLike(url, id, interf) {
    $.post(
        url, 
        {id: id},
        function(data) {
            atualiza(interf, data);
        }
    );
}
