$(document).ready(function() {

    $('a.com_up').click(function() {
        var id = $(this).data('id');
        $.post(
            '/voto-comentario-up', 
            {id: id},
            function(data) {
                atualizaComentario(id, data.pontos, 'Gostei');
            }
        );
    });


    $('a.com_down').click(function() {
        var id = $(this).data('id');
        $.post(
            '/voto-comentario-down', 
            {id: id},
            function(data) {
                atualizaComentario(id, data.pontos, 'Não gostei');
            }
        );
    });

});

function atualizaComentario(id, pontos, meu_voto) {
    $('.voto_comentario[data-pontos-id=' + id + ']').text(pontos + (Math.abs(pontos) > 1 ? ' pontos' : ' ponto'));
    $('.meu_voto_com[data-pontos-id=' + id + ']').text(meu_voto);
}
