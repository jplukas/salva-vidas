# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_14_171836) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "material_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_bookmarks_on_material_id"
    t.index ["user_id", "material_id"], name: "index_bookmarks_on_user_id_and_material_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "comentarios", force: :cascade do |t|
    t.text "conteudo"
    t.integer "user_id"
    t.integer "material_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_comentarios_on_material_id"
    t.index ["user_id"], name: "index_comentarios_on_user_id"
  end

  create_table "cursos", force: :cascade do |t|
    t.string "nome", null: false
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nome"], name: "index_cursos_on_nome"
  end

  create_table "disciplinas", force: :cascade do |t|
    t.string "nome", null: false
    t.text "desc"
    t.integer "curso_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curso_id"], name: "index_disciplinas_on_curso_id"
    t.index ["nome"], name: "index_disciplinas_on_nome"
  end

  create_table "materials", force: :cascade do |t|
    t.string "nome", null: false
    t.text "conteudo", null: false
    t.integer "disciplina_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.index ["disciplina_id"], name: "index_materials_on_disciplina_id"
    t.index ["nome", nil, nil], name: "index_materials_on_nome_and_disciplina_and_user"
    t.index ["user_id"], name: "index_materials_on_user_id"
  end

  create_table "rel_user_disciplinas", force: :cascade do |t|
    t.integer "seguidor_id"
    t.integer "seguido_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seguido_id", "seguidor_id"], name: "index_rel_user_disciplinas_on_seguido_id_and_seguidor_id", unique: true
    t.index ["seguido_id"], name: "index_rel_user_disciplinas_on_seguido_id"
    t.index ["seguidor_id"], name: "index_rel_user_disciplinas_on_seguidor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "voto_comentarios", force: :cascade do |t|
    t.integer "comentario_id"
    t.integer "user_id"
    t.integer "sinal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comentario_id"], name: "index_voto_comentarios_on_comentario_id"
    t.index ["user_id"], name: "index_voto_comentarios_on_user_id"
  end

  create_table "votos", force: :cascade do |t|
    t.integer "material_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sinal"
    t.index ["material_id"], name: "index_votos_on_material_id"
    t.index ["user_id"], name: "index_votos_on_user_id"
  end

end
