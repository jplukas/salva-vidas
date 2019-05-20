class Disciplina < ApplicationRecord
  belongs_to :curso
  has_many :materials

  validates :nome, presence: true, uniqueness: true, length: {maximum: 40}
  validates :desc, presence: true
end
