describe('Interface de like e dislike (estado atual obtido do servidor)', function() {

    var URL_TESTE_LIKE = '/url-de-likes';

    function mockaUrl(resposta) {
        jasmine.Ajax.stubRequest(URL_TESTE_LIKE).andReturn({responseJSON: resposta});
    }
    
    function testaLike() {
        mockaUrl({pontos: 1, voto: 1});
        cliqueLike(URL_TESTE_LIKE, 1, interf);
        expect(interf.pontos.text()).toBe('1 ponto');
        expect(interf.meu_voto.text()).toBe('Gostei');
        expect($('img', interf.up).attr('src')).toContain('up-ativo.png');
        expect($('img', interf.down).attr('src')).toContain('down-inativo.png');
    }
    
    function testaDislike() {
        mockaUrl({pontos: 1, voto: -1});
        cliqueLike(URL_TESTE_LIKE, 1, interf);
        expect(interf.pontos.text()).toBe('1 ponto');
        expect(interf.meu_voto.text()).toBe('Não gostei');
        expect($('img', interf.up).attr('src')).toContain('up-inativo.png');
        expect($('img', interf.down).attr('src')).toContain('down-ativo.png');
    }
    
    var interf;
    
    beforeEach(function() {
        interf = {
            pontos: $('<div></div>'),
            meu_voto: $('<div></div>'),
            up: $('<div></div>'),
            down: $('<div></div>')
        }
        jasmine.Ajax.install();
    });
    
    afterEach(function() {
        jasmine.Ajax.uninstall();
    });

    it('Dá like quando não tem voto', testaLike);

    it('Dá dislike quando não tem voto', testaDislike);

    it('Tira like quando já tem', function() {
        mockaUrl({pontos: 1, voto: 0});
        cliqueLike(URL_TESTE_LIKE, 1, interf);
        expect(interf.pontos.text()).toBe('1 ponto');
        expect(interf.meu_voto.text()).toBe('');
        expect($('img', interf.up).attr('src')).toContain('up-inativo.png');
        expect($('img', interf.down).attr('src')).toContain('down-inativo.png');
    });

    it('Tira dislike quando já tem', function() {
        mockaUrl({pontos: 1, voto: 0});
        cliqueLike(URL_TESTE_LIKE, 1, interf);
        expect(interf.pontos.text()).toBe('1 ponto');
        expect(interf.meu_voto.text()).toBe('');
        expect($('img', interf.up).attr('src')).toContain('up-inativo.png');
        expect($('img', interf.down).attr('src')).toContain('down-inativo.png');
    });
    
    it('Troca o like para dislike', function() {
        testaLike();
        testaDislike();
    });
    
    it('Troca o dislike para like', function() {
        testaDislike();
        testaLike();
    });
    
    it('Pluraliza os pontos', function() {
        mockaUrl({pontos: 0, voto: 0});
        cliqueLike(URL_TESTE_LIKE, 1, interf);
        expect(interf.pontos.text()).toBe('0 ponto');
        mockaUrl({pontos: 1, voto: 0});
        cliqueLike(URL_TESTE_LIKE, 1, interf);
        expect(interf.pontos.text()).toBe('1 ponto');
        mockaUrl({pontos: 2, voto: 0});
        cliqueLike(URL_TESTE_LIKE, 1, interf);
        expect(interf.pontos.text()).toBe('2 pontos');
        mockaUrl({pontos: -1, voto: 0});
        cliqueLike(URL_TESTE_LIKE, 1, interf);
        expect(interf.pontos.text()).toBe('-1 ponto');
        mockaUrl({pontos: -2, voto: 0});
        cliqueLike(URL_TESTE_LIKE, 1, interf);
        expect(interf.pontos.text()).toBe('-2 pontos');
    });
    
});
