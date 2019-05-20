class Comentario < ApplicationRecord
  belongs_to :user
  belongs_to :material

  validates :conteudo, presence: true, length: {maximum: 300}
end
