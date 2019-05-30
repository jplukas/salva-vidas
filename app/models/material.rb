class Material < ApplicationRecord
  belongs_to :disciplina
  belongs_to :user
  has_many :comentarios
  has_many :votos

  validates :nome, presence: true, uniqueness: true, length: {maximum: 50}
  validates :conteudo, presence: true
end
