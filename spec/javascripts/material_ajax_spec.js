describe('Postagem de material', function() {
    
    var disciplina_combo;
    var mock1 = [{"id":1, "nome":"disc1"}, {"id":2, "nome":"disc2"}, {"id":3, "nome":"disc3"}];
    var mock2 = [{"id":4, "nome":"disc4"}, {"id":5, "nome":"disc5"}]
    var perigo = [{"id":6, "nome":"<script>alert(1)</script>"}]
    
    function testaMock(mock) {
        $('option', disciplina_combo).each(function(idx) {
            expect(parseInt($(this).attr('value'))).toBe(mock[idx].id);
            expect($(this).text()).toBe(mock[idx].nome);
        });
    }
    
    beforeEach(function() {
        jasmine.Ajax.install();
        jasmine.Ajax.stubRequest('/cursos/1/disciplinas.json').andReturn({
            "responseJSON": mock1
        });
        jasmine.Ajax.stubRequest('/cursos/2/disciplinas.json').andReturn({
            "responseJSON": mock2
        });
        jasmine.Ajax.stubRequest('/cursos/3/disciplinas.json').andReturn({
            "responseJSON": perigo
        });
        disciplina_combo = $('<select></select>');
    });
    
    afterEach(function() {
        jasmine.Ajax.uninstall();
    });
    
    it('Carrega as disciplinas quando seleciona o curso', function() {
        atualizaPorAjax(disciplina_combo, 1);
        testaMock(mock1);
    });
    
    it('Não acumula no combo as disciplinas do curso anteriormente selecionado', function() {
        atualizaPorAjax(disciplina_combo, 1);
        testaMock(mock1);
        atualizaPorAjax(disciplina_combo, 2);
        testaMock(mock2);
        atualizaPorAjax(disciplina_combo, 1);
        testaMock(mock1);
        atualizaPorAjax(disciplina_combo, 2);
        testaMock(mock2);
    });
    
    it('Faz escape de HTML vindo da API', function() {
        atualizaPorAjax(disciplina_combo, 3);
        expect(disciplina_combo.html()).not.toContain('<script>');
        expect(disciplina_combo.html()).not.toContain('</script>');
        expect(disciplina_combo.html()).toContain('&lt;script&gt;');
        expect(disciplina_combo.html()).toContain('&lt;/script&gt;');
    });
    
});
