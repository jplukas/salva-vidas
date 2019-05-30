$(document).ready(function() {

    $('a.up').click(function() {
        var id = $(this).data('id');
        $.post(
            '/voto-up', 
            {id: id},
            function(data) {
                atualiza(id, data.pontos, +1);
            }
        );
    });


    $('a.down').click(function() {
        var id = $(this).data('id');
        $.post(
            '/voto-down', 
            {id: id},
            function(data) {
                atualiza(id, data.pontos, -1);
            }
        );
    });

});

function atualiza(id, pontos, meu_voto) {
    $('span[data-pontos-id=' + id + ']').text(pontos + (Math.abs(pontos) > 1 ? ' pontos' : ' ponto'));
    if (meu_voto == +1)
        $('.meu_voto[data-pontos-id=' + id + ']').text('Gostei');
    else
        $('.meu_voto[data-pontos-id=' + id + ']').text('Nao gostei');
}
