class RelUserDisciplina < ApplicationRecord
    belongs_to :seguidor, class_name: "User"
    belongs_to :seguido, class_name: "Disciplina"  
    validates :seguidor_id, presence: true
    validates :seguido_id, presence: true    
end
