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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120206132911) do

  create_table "auteurs", :force => true do |t|
    t.string   "prenom_auteur"
    t.string   "nom_auteur"
    t.string   "mot_de_passe"
    t.string   "salt"
    t.string   "pseudo_auteur",        :default => "Anonyme"
    t.string   "adresse"
    t.string   "email"
    t.string   "ville"
    t.integer  "age"
    t.string   "sexe"
    t.string   "id_facebook"
    t.string   "biographie_auteur"
    t.string   "id_twitter"
    t.string   "site_auteur"
    t.integer  "changer_mot_de_passe"
    t.integer  "peut_changer_mdp"
    t.datetime "date_validite"
    t.boolean  "deleted"
    t.string   "create_by"
    t.string   "update_by"
    t.string   "delete_by"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contact"
  end

  create_table "lien_signalers", :force => true do |t|
    t.integer  "lien_id"
    t.string   "url_lien"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "liens", :force => true do |t|
    t.string   "titre_lien"
    t.text     "description_lien"
    t.string   "url_lien"
    t.text     "image_lien"
    t.boolean  "deleted"
    t.string   "create_by"
    t.string   "update_by"
    t.string   "delete_by"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "liens_auteurs", :force => true do |t|
    t.integer  "lien_id"
    t.integer  "auteur_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "liens_votes", :force => true do |t|
    t.integer  "lien_id"
    t.integer  "sum_lien_votes_positifs"
    t.integer  "sum_liens_votes_negatifs"
    t.string   "create_by"
    t.string   "update_by"
    t.string   "delete_by"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "liens_votes_negatifs", :force => true do |t|
    t.integer  "lien_id"
    t.string   "ip_lien_votes_negatifs"
    t.string   "user_agent_lien_votes_negatif"
    t.boolean  "deleted"
    t.string   "create_by"
    t.string   "update_by"
    t.string   "delete_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "liens_votes_positifs", :force => true do |t|
    t.integer  "lien_id"
    t.string   "ip_lien_votes_positifs"
    t.string   "user_agent_lien_votes_positifs"
    t.boolean  "deleted"
    t.string   "create_by"
    t.string   "update_by"
    t.string   "delete_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "code_role"
    t.string   "description_role"
    t.boolean  "deleted"
    t.string   "create_by"
    t.string   "update_by"
    t.string   "delete_by"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_auteurs", :force => true do |t|
    t.integer  "auteur_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
