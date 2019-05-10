class Material < ApplicationRecord
  belongs_to :disciplina
  has_many :comentarios
end
