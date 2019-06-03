$(document).ready(function() {

    $(document).on('click', 'a.com_up', function() {
        var id = $(this).data('id');
        $.post(
            '/voto-comentario-up', 
            {id: id},
            function(data) {
                atualizaComentario(id, data.pontos, data.voto);
            }
        );
    });


    $(document).on('click', 'a.com_down', function() {
        var id = $(this).data('id');
        $.post(
            '/voto-comentario-down', 
            {id: id},
            function(data) {
                atualizaComentario(id, data.pontos, data.voto);
            }
        );
    });

});

function atualizaComentario(id, pontos, meu_voto) {
    $('.voto_comentario[data-pontos-id=' + id + ']').text(pontos + (Math.abs(pontos) > 1 ? ' pontos' : ' ponto'));
    $('.meu_voto_com[data-pontos-id=' + id + ']').text(meu_voto == +1 ? 'Gostei' : (meu_voto == -1 ? 'Não gostei' : ''));
    $('a.com_up[data-id=' + id + ']').html('<img src="/assets/' + (meu_voto == +1 ? 'up-ativo' : 'up-inativo') + '.png">');
    $('a.com_down[data-id=' + id + ']').html('<img src="/assets/' + (meu_voto == -1 ? 'down-ativo' : 'down-inativo') + '.png">');
}
