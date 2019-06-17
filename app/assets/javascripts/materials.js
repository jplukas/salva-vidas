var URL_UP = '/voto-up';
var URL_DOWN = '/voto-down';

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

function interfaceMaterial(id) {
    return {
        pontos: $('.voto_material[data-pontos-id=' + id + ']'),
        meu_voto: $('.meu_voto[data-pontos-id=' + id + ']'),
        up: $('a.up[data-id=' + id + ']'),
        down: $('a.down[data-id=' + id + ']')
    };
}

$(document).ready(function() {

    $(document).on('click', 'a.up', function() {
        var id = $(this).data('id');
        cliqueLike(URL_UP, id, interfaceMaterial(id));
    });
    
    $(document).on('click', 'a.down', function() {
        var id = $(this).data('id');
        cliqueLike(URL_DOWN, id, interfaceMaterial(id));
    });

    $(document).on('change', 'p.selecao_curso select', function() {
        var id_curso = parseInt($(this).val());
        atualizaPorAjax($('#material_disciplina_id'), id_curso);
    });

});
