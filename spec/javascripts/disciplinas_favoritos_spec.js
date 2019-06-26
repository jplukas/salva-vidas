describe('Estado do botão favoritar muda de acordo com a resposta do servidor', function() {

    var URL_TESTE_LIKE = '/favoritar';
    var estrelinha;
    
    beforeEach(function() {
        jasmine.Ajax.install();
        estrelinha = $('<a></a>');
    });
    
    afterEach(function() {
        jasmine.Ajax.uninstall();
    });
    
    function mockaUrl(resposta) {
        jasmine.Ajax.stubRequest(URL_TESTE_LIKE).andReturn({
            responseJSON: {
                bookmarked: resposta
            }
        });
    }
    
    it('fica amarelo quando favorita', function() {
        mockaUrl(true);
        favoritar(estrelinha);
        expect($('img', estrelinha).attr('src')).toContain('favorito-ativo');
    });
    
    it('fica cinza quando desfavorita', function() {
        mockaUrl(false);
        favoritar(estrelinha);
        console.log(estrelinha);        
        expect($('img', estrelinha).attr('src')).toContain('favorito-inativo');
    });
    
});
