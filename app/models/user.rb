class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :materials
  has_many :comentarios
  has_many :votos
  
  has_many :rel_user_disciplinas, foreign_key: "seguidor_id", dependent: :destroy
  has_many :seguindo, through: :rel_user_disciplinas, source: :seguido

  has_many :materiais_seguidos, class_name: "Material", through: :seguindo, source: :materials

  validates :nome, presence: true, length: {maximum: 15}
end
