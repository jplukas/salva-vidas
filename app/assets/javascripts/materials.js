var URL_UP = '/voto-up';
var URL_DOWN = '/voto-down';

var cursos_disciplinas_cache = {};

function carregarComboCom(combo_disciplina, disciplinas) {
    $('option', combo_disciplina).remove()
    for (d in disciplinas) {
        var option = document.createElement('option');
        option.value = parseInt(disciplinas[d].id);
        option.textContent = disciplinas[d].nome;  // Faz o escape :)
        combo_disciplina.append(option);
    }
}

function atualizaPorAjax(combo_disciplina, id_curso) {
    if (cursos_disciplinas_cache[id_curso]) {
        carregarComboCom(combo_disciplina, cursos_disciplinas_cache[id_curso]);
        return;
    }

    $.get(
        '/cursos/' + id_curso + '/disciplinas.json',
        function(disciplinas) {
            cursos_disciplinas_cache[id_curso] = disciplinas;
            carregarComboCom(combo_disciplina, disciplinas);
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
    
    $('p.selecao_curso select').change();

});
