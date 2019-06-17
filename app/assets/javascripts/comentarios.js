var URL_COM_UP = '/voto-comentario-up';
var URL_COM_DOWN = '/voto-comentario-down';

function interfaceComentario(id) {
    return {
        pontos: $('.voto_comentario[data-pontos-id=' + id + ']'),
        meu_voto: $('.meu_voto_com[data-pontos-id=' + id + ']'),
        up: $('a.com_up[data-id=' + id + ']'),
        down: $('a.com_down[data-id=' + id + ']')
    };
}

$(document).ready(function() {

    $(document).on('click', 'a.com_up', function() {
        var id = $(this).data('id');
        cliqueLike(URL_COM_UP, id, interfaceComentario(id));
    });
    
    $(document).on('click', 'a.com_down', function() {
        var id = $(this).data('id');
        cliqueLike(URL_COM_DOWN, id, interfaceComentario(id));
    });

});
