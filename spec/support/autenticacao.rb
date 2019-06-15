module AutenticacaoHelpers

    def cria_usuario(email="usuario@teste.com")
        usuario = User.create({email: email, 
            encrypted_password: "$2a$11$pN6b558y9eF4zeIN7cfQzeZ3QkCKRwN2kkwy8nB5mEr53dVwLeNNS", 
            reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, 
            nome: "Usuário Teste"})
        usuario.save(validate: false)
        usuario
    end
    
    def cria_admin
        admin = User.create({email: "admin@admin.com", 
            encrypted_password: "$2a$11$xurTYzz4VlCKBVpwDOIojuygYqpKFDuV8H4wKnI3EoiTGnj2pOTu6", 
            reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, 
            nome: "Administrador", admin: true})
        admin.save(validate: false)
        admin
    end

    def login(user)
        puts user_session_path
        post user_session_path, params: {user: {email: user.email, password: user.password}}
        puts 'LOGIN'
        puts response.body
        expect(response.status).to eq(200)
    end
    
    def cria_e_loga
        user = cria_usuario
        login user
        user
    end


end

RSpec.configure do |c|
  c.include AutenticacaoHelpers
end

