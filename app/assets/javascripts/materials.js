$(document).ready(function() {

    $(document).on('click', 'a.up', function() {
        var id = $(this).data('id');
        $.post(
            '/voto-up', 
            {id: id},
            function(data) {
                atualiza(id, data.pontos, data.voto);
            }
        );
    });


    $(document).on('click', 'a.down', function() {
        var id = $(this).data('id');
        $.post(
            '/voto-down', 
            {id: id},
            function(data) {
                atualiza(id, data.pontos, data.voto);
            }
        );
    });
    
    $(document).on('change', 'p.selecao_curso select', function() {
        var id_curso = parseInt($(this).val());
        $.get(
            'http://localhost:3000/cursos/' + id_curso + '/disciplinas.json',
            function(cursos) {
                $('#material_disciplina_id option').remove()
                for (c in cursos) {
                    var option = document.createElement('option');
                    option.value = parseInt(cursos[c].id);
                    option.textContent = cursos[c].nome;  // Faz o escape :)
                    $('#material_disciplina_id').append(option);
                }
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
