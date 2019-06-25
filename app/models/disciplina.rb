class Disciplina < ApplicationRecord
  belongs_to :curso
  has_many :materials

  has_many :rel_user_disciplinas, foreign_key: "seguido_id", dependent: :destroy
  has_many :seguidores, through: :rel_user_disciplinas, source: :seguidor
  
  has_one :figura_disciplina

  validates :nome, presence: true, uniqueness: true, length: {maximum: 40}
  validates :desc, presence: true
end
