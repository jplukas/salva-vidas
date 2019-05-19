class Material < ApplicationRecord
  belongs_to :disciplina
  belongs_to :user
  has_many :comentarios
  has_many :votos
end
