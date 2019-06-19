class Bookmark < ApplicationRecord
    belongs_to :user
    belongs_to :material  
    validates :user_id, presence: true
    validates :material_id, presence: true
end
