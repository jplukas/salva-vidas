class Comentario < ApplicationRecord
  belongs_to :user
  belongs_to :material
  has_many :voto_comentarios, dependent: :destroy

  validates :conteudo, presence: true, length: {maximum: 300}
end
