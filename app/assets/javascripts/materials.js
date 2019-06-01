$(document).ready(function() {

    $('a.up').click(function() {
        var id = $(this).data('id');
        $.post(
            '/voto-up', 
            {id: id},
            function(data) {
                atualiza(id, data.pontos, data.voto);
            }
        );
    });


    $('a.down').click(function() {
        var id = $(this).data('id');
        $.post(
            '/voto-down', 
            {id: id},
            function(data) {
                atualiza(id, data.pontos, data.voto);
            }
        );
    });

});

function atualiza(id, pontos, meu_voto) {
    $('.voto_material[data-pontos-id=' + id + ']').text(pontos + (Math.abs(pontos) > 1 ? ' pontos' : ' ponto'));
    $('.meu_voto[data-pontos-id=' + id + ']').text(meu_voto == +1 ? 'Gostei' : (meu_voto == -1 ? 'Não gostei' : ''));
    $('a.up[data-id=' + id + ']').html('<img src="/assets/' + (meu_voto == +1 ? 'up-ativo' : 'up-inativo') + '.png">');
    $('a.down[data-id=' + id + ']').html('<img src="/assets/' + (meu_voto == -1 ? 'down-ativo' : 'down-inativo') + '.png">');
}
