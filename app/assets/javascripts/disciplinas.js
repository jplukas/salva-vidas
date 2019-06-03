$(document).ready(function() {

    $(document).on('click', '.fav-button a', function() {
        var link = $(this);
        var id = link.data('id');
        $.post(
            '/favoritar', 
            {id: id},
            function(data) {
                link.html('<img src="/assets/' + (data.bookmarked ? 'favorito-ativo' : 'favorito-inativo') + '.png">');
            }
        );
    });
    
});
