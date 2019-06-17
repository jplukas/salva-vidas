function atualizaPorAjax(combo_disciplina, id_curso) {
    $.get(
        '/cursos/' + id_curso + '/disciplinas.json',
        function(disciplinas) {
            $('option', combo_disciplina).remove()
            for (d in disciplinas) {
                var option = document.createElement('option');
                option.value = parseInt(disciplinas[d].id);
                option.textContent = disciplinas[d].nome;  // Faz o escape :)
                combo_disciplina.append(option);
            }
        }
    );
}


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
        atualizaPorAjax($('#material_disciplina_id'), id_curso);
    });

});

function atualiza(id, pontos, meu_voto) {
    $('.voto_material[data-pontos-id=' + id + ']').text(pontos + (Math.abs(pontos) > 1 ? ' pontos' : ' ponto'));
    $('.meu_voto[data-pontos-id=' + id + ']').text(meu_voto == +1 ? 'Gostei' : (meu_voto == -1 ? 'Não gostei' : ''));
    $('a.up[data-id=' + id + ']').html('<img src="/assets/' + (meu_voto == +1 ? 'up-ativo' : 'up-inativo') + '.png">');
    $('a.down[data-id=' + id + ']').html('<img src="/assets/' + (meu_voto == -1 ? 'down-ativo' : 'down-inativo') + '.png">');
}
