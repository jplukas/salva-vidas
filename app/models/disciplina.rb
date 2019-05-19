class Disciplina < ApplicationRecord
  belongs_to :curso
  has_many :materials
end
