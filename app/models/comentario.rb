class Comentario < ApplicationRecord
  belongs_to :user
  belongs_to :material
end