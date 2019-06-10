class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :materials
  has_many :comentarios
  has_many :votos
  
  has_many :rel_user_disciplinas, foreign_key: "seguidor_id", dependent: :destroy
  has_many :seguindo, through: :rel_user_disciplinas, source: :seguido

  has_many :materiais_seguidos, class_name: "Material", through: :seguindo, source: :materials

  has_many :bookmarks
  has_many :material_bookmarks, class_name: "Material", through: :bookmarks, source: :material_id

  validates :nome, presence: true, length: {maximum: 15}

  def seguindo? (disciplina)
    seguindo.include?(disciplina)
  end

  def seguir (disciplina)
    seguindo << disciplina unless seguindo?(disciplina)
  end

  def deixar_de_seguir (disciplina)
    seguindo.delete(disciplina)
  end

  def bookmarked? (material)
    material_bookmarks.include?(material)
  end

  def seguir (material)
    material_bookmarks << material unless bookmarked?(material)
  end

  def un_bookmark (material)
    material_bookmarks.delete(material)
  end

  def feed
    materiais_seguidos.order(created_at: :desc)
  end
  
end
