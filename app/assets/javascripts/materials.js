$(document).ready(function() {

    $('a.up').click(function() {
        var id = $(this).data('id');
        $.post(
            '/voto-up', 
            {id: id},
            function(data) {
                atualiza(id, data.pontos, 'Gostei');
            }
        );
    });


    $('a.down').click(function() {
        var id = $(this).data('id');
        $.post(
            '/voto-down', 
            {id: id},
            function(data) {
                atualiza(id, data.pontos, 'Não gostei');
            }
        );
    });

});

function atualiza(id, pontos, meu_voto) {
    $('.voto_material[data-pontos-id=' + id + ']').text(pontos + (Math.abs(pontos) > 1 ? ' pontos' : ' ponto'));
    $('.meu_voto[data-pontos-id=' + id + ']').text(meu_voto);
}
