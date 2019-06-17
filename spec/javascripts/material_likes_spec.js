describe('Like e dislike', function() {

    function mockaUrl(url, resposta) {
        jasmine.Ajax.stubRequest(url).andReturn({
            responseJSON: resposta
        });
    }
    
    function testaLike() {
        mockaUrl('/voto-up', {pontos: 1, voto: 1});
        cliqueLike(URL_UP, 1, interf);
        expect(interf.pontos.text()).toBe('1 ponto');
        expect(interf.meu_voto.text()).toBe('Gostei');
        expect($('img', interf.up).attr('src')).toContain('up-ativo.png');
        expect($('img', interf.down).attr('src')).toContain('down-inativo.png');
    }
    
    function testaDislike() {
        mockaUrl('/voto-down', {pontos: 1, voto: -1});
        cliqueLike(URL_DOWN, 1, interf);
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

    it('Tira like quando dá 2 vezes', function() {
        mockaUrl('/voto-up', {pontos: 1, voto: 0});
        cliqueLike(URL_UP, 1, interf);
        expect(interf.pontos.text()).toBe('1 ponto');
        expect(interf.meu_voto.text()).toBe('');
        expect($('img', interf.up).attr('src')).toContain('up-inativo.png');
        expect($('img', interf.down).attr('src')).toContain('down-inativo.png');
    });

    it('Tira dislike quando dá 2 vezes', function() {
        mockaUrl('/voto-down', {pontos: 1, voto: 0});
        cliqueLike(URL_DOWN, 1, interf);
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
    
});
