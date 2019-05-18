# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

curso=Curso.create!({nome:'BCC'})
disciplina=Disciplina.create!({nome:'TecProg2', curso:curso})
material1=Material.create!({titulo:'A',disciplina:disciplina})
material2=Material.create!({titulo:'B', disciplina:disciplina})
