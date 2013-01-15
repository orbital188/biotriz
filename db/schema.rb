# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130115024911) do

  create_table "complexities", :force => true do |t|
    t.string   "title",       :limit => 250, :null => false
    t.text     "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "complexities", ["title"], :name => "index_complexities_on_title", :unique => true

  create_table "entities", :force => true do |t|
    t.string   "title",         :null => false
    t.text     "description"
    t.string   "ancestry"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "size_id"
    t.integer  "complexity_id"
  end

  add_index "entities", ["ancestry", "title"], :name => "index_entities_on_ancestry_and_title"
  add_index "entities", ["ancestry"], :name => "index_entities_on_ancestry"

  create_table "entities_ent_functions", :id => false, :force => true do |t|
    t.integer "entity_id"
    t.integer "entity_function_id"
  end

  add_index "entities_ent_functions", ["entity_function_id", "entity_id"], :name => "index_entities_ent_functions_on_entity_function_id_and_entity_id"
  add_index "entities_ent_functions", ["entity_id", "entity_function_id"], :name => "index_entities_ent_functions_on_entity_id_and_entity_function_id"

  create_table "entities_environments", :id => false, :force => true do |t|
    t.integer "entity_id"
    t.integer "environment_id"
  end

  add_index "entities_environments", ["entity_id", "environment_id"], :name => "index_entities_environments_on_entity_id_and_environment_id"
  add_index "entities_environments", ["environment_id", "entity_id"], :name => "index_entities_environments_on_environment_id_and_entity_id"

  create_table "entity_actions", :force => true do |t|
    t.string   "title",       :limit => 250, :null => false
    t.text     "description"
    t.string   "ancestry"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "entity_actions", ["ancestry", "title"], :name => "index_entity_actions_on_ancestry_and_title", :unique => true
  add_index "entity_actions", ["ancestry"], :name => "index_entity_actions_on_ancestry"

  create_table "entity_functions", :force => true do |t|
    t.string   "title",       :limit => 250, :null => false
    t.text     "description"
    t.string   "ancestry"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "entity_functions", ["ancestry", "title"], :name => "index_entity_functions_on_ancestry_and_title", :unique => true
  add_index "entity_functions", ["ancestry"], :name => "index_entity_functions_on_ancestry"

  create_table "environment_parameters", :force => true do |t|
    t.string   "title",       :limit => 250, :null => false
    t.text     "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "environment_parameters", ["title"], :name => "index_environment_parameters_on_title", :unique => true

  create_table "environments", :force => true do |t|
    t.string   "title",       :limit => 250, :null => false
    t.text     "description"
    t.string   "ancestry"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "environments", ["ancestry", "title"], :name => "index_environments_on_ancestry_and_title", :unique => true
  add_index "environments", ["ancestry"], :name => "index_environments_on_ancestry"

  create_table "parameters", :force => true do |t|
    t.string   "title",       :limit => 250, :null => false
    t.text     "description"
    t.string   "ancestry"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "parameters", ["ancestry", "title"], :name => "index_parameters_on_ancestry_and_title", :unique => true
  add_index "parameters", ["ancestry"], :name => "index_parameters_on_ancestry"

  create_table "principles", :force => true do |t|
    t.string   "title",            :limit => 250, :null => false
    t.text     "description"
    t.string   "ancestry"
    t.integer  "principle_number"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "principles", ["title"], :name => "index_principles_on_title", :unique => true

  create_table "sizes", :force => true do |t|
    t.string   "title",       :limit => 250, :null => false
    t.text     "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "sizes", ["title"], :name => "index_sizes_on_title", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
