User.create!([
  {email: "jplukasavicus@gmail.com", encrypted_password: "$2a$11$Ab4Fd3.XtXbe0rbcyGd3GuXvE5n1LpBBpoD72RkuJDlXCJSFp0uHi", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, nome: "João Pedro"},
  {email: "lukasavicus@gmail.com", encrypted_password: "$2a$11$pN6b558y9eF4zeIN7cfQzeZ3QkCKRwN2kkwy8nB5mEr53dVwLeNNS", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, nome: "Lucas silva"}
])
Comentario.create!([
  {conteudo: "Eh foda dmais msm", user_id: 1, material_id: 1},
  {conteudo: "nadave", user_id: 2, material_id: 1},
  {conteudo: "Toma no cu todo dia essa porra", user_id: 2, material_id: 3},
  {conteudo: "Esse puto nem sabe do que ta falando, te fude rapa\r\nVO TE PEGA FELA DA PULTA, AQUI A FIRMA EH FORTEMENTE FORNECIDA", user_id: 2, material_id: 1},
  {conteudo: "\r\naskdjkasd", user_id: 1, material_id: 1},
  {conteudo: "adsasdasd", user_id: 1, material_id: 1},
  {conteudo: "Bro, did you just post cringe?", user_id: 1, material_id: 5},
  {conteudo: "É, achei uma bosta mesmo", user_id: 1, material_id: 5}
])
Curso.create!([
  {nome: "Computacao", desc: "Computaria ;)"}
])
Disciplina.create!([
  {nome: "MAC 101", desc: "Introducao a computacao, se pegar dp fudeu", curso_id: 1},
  {nome: "Teste", desc: "disciplina de teste", curso_id: 1},
  {nome: "teste2", desc: "segundo teste das disciplinas", curso_id: 1},
  {nome: "teste3", desc: "terceiro teste das disciplinas", curso_id: 1}
])
Material.create!([
  {nome: "Algorithms 5th edition, Sedgwick", conteudo: "Melhor livro nessa porra, caralho!", disciplina_id: 1, user_id: 1},
  {nome: "Computador", conteudo: "Excelente para computar\r\nduh!", disciplina_id: 1, user_id: 2},
  {nome: "bruh", conteudo: "what", disciplina_id: 1, user_id: 1},
  {nome: "Bruh", conteudo: "What the fuck did you just fucking say about me, you little bitch? I'll have you know I graduated top of my class in the Navy Seals, and I've been involved in numerous secret raids on Al-Quaeda, and I have over 300 confirmed kills. I am trained in gorilla warfare and I'm the top sniper in the entire US armed forces. You are nothing to me but just another target. I will wipe you the fuck out with precision the likes of which has never been seen before on this Earth, mark my fucking words. You think you can get away with saying that shit to me over the Internet?", disciplina_id: 1, user_id: 1},
  {nome: "Teste de link", conteudo: "https://www.facebook.com/", disciplina_id: 1, user_id: 1}
])
Voto.create!([
  {material_id: 1, user_id: 1, up: "true"}
])
