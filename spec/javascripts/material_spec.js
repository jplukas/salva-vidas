describe('Postagem de material', function() {
    
    it ('carrega as disciplinas quando seleciona o curso', function() {
        jasmine.Ajax.install();
        jasmine.Ajax.stubRequest('/cursos/1/disciplinas.json').andReturn({
            "responseJSON": [{"id":1, "nome":"disc1"}, {"id":2, "nome":"disc2"}, {"id":3, "nome":"disc3"}]
        });
        
        var disciplina_combo = $('<select></select>');
        atualizaPorAjax(disciplina_combo, 1);
        
        var mock = ['disc1', 'disc2', 'disc3'];
        $('option', disciplina_combo).each(function(idx) {
            console.log(idx, this);
            expect(parseInt($(this).attr('value'))).toBe(idx+1);
            expect($(this).text()).toBe(mock[idx]);
        });
        
        jasmine.Ajax.uninstall();
    });

});
