class Voto < ApplicationRecord
  belongs_to :material
  belongs_to :user

  validates :sinal, presence: true
  validates_inclusion_of :sinal, in: [-1, +1]
  validates_uniqueness_of :user_id, scope: [:material_id]
end
