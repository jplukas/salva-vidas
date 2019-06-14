class Curso < ApplicationRecord
    has_many :disciplinas
    has_many :materials, through: :disciplinas
    has_one_attached :figura
    validates :nome, presence: true, uniqueness: true, length: {maximum: 30}
    validates :desc, presence: true
end
