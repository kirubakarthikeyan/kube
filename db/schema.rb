# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_08_080311) do
  create_table "applications", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "environment_id"
    t.string "uuid", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.string "source_type", null: false
    t.string "git_repository"
    t.string "git_branch"
    t.string "docker_file_path"
    t.string "docker_image"
    t.integer "min_instances", null: false
    t.integer "max_instances", null: false
    t.integer "external_ip_address"
    t.integer "internal_ip_address"
    t.float "cpu_cores", null: false
    t.float "memory", null: false
    t.string "chart_version", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["environment_id", "slug"], name: "index_applications_on_environment_id_and_slug", unique: true
    t.index ["environment_id"], name: "index_applications_on_environment_id"
  end

  create_table "cloud_accounts", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "project_id"
    t.string "name"
    t.string "slug"
    t.string "type"
    t.json "credentials"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_cloud_accounts_on_project_id"
  end

  create_table "clusters", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "cloud_account_id"
    t.bigint "project_id"
    t.string "name", null: false
    t.string "uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cloud_account_id"], name: "index_clusters_on_cloud_account_id"
    t.index ["project_id"], name: "index_clusters_on_project_id"
    t.index ["uuid"], name: "index_clusters_on_uuid", unique: true
  end

  create_table "databases", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "environment_id"
    t.string "type", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.string "mode", null: false
    t.string "version", null: false
    t.json "configuration"
    t.string "chart_version", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["environment_id", "slug"], name: "index_databases_on_environment_id_and_slug", unique: true
    t.index ["environment_id"], name: "index_databases_on_environment_id"
  end

  create_table "deployments", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "environment_id"
    t.bigint "triggered_user_id"
    t.string "uuid", null: false
    t.string "status", null: false
    t.json "payload", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["environment_id"], name: "index_deployments_on_environment_id"
    t.index ["triggered_user_id"], name: "index_deployments_on_triggered_user_id"
    t.index ["uuid"], name: "index_deployments_on_uuid", unique: true
  end

  create_table "environments", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "cluster_id"
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_environments_on_cluster_id"
    t.index ["project_id"], name: "index_environments_on_project_id"
  end

  create_table "jwt_denylist", charset: "utf8mb3", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "key_value_pairs", charset: "utf8mb3", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "type", null: false
    t.string "key", null: false
    t.text "value", size: :medium, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id", "type", "key"], name: "index_key_value_pairs_on_owner_type_and_key", unique: true
    t.index ["owner_type", "owner_id"], name: "index_key_value_pairs_on_owner"
  end

  create_table "letsencrypt_certificates", charset: "utf8mb3", force: :cascade do |t|
    t.string "domain"
    t.text "certificate"
    t.text "intermediaries"
    t.text "key"
    t.datetime "expires_at"
    t.datetime "renew_after"
    t.string "verification_path"
    t.string "verification_string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "challenge_type"
    t.json "challenge_details"
    t.index ["domain"], name: "index_letsencrypt_certificates_on_domain"
    t.index ["renew_after"], name: "index_letsencrypt_certificates_on_renew_after"
  end

  create_table "organizations", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "owner_id"
    t.string "name", null: false
    t.string "slug", null: false
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_organizations_on_owner_id"
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "owners", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_owners_on_user_id"
  end

  create_table "ports", charset: "utf8mb3", force: :cascade do |t|
    t.string "service_type"
    t.bigint "service_id"
    t.integer "internal_port"
    t.integer "external_port"
    t.boolean "publicly_accessible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_type", "service_id"], name: "index_ports_on_service"
  end

  create_table "projects", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "organization_id"
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_projects_on_organization_id"
  end

  create_table "routers", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "environment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["environment_id"], name: "index_routers_on_environment_id"
  end

  create_table "service_states", charset: "utf8mb3", force: :cascade do |t|
    t.string "service_type"
    t.bigint "service_id"
    t.integer "available_instances"
    t.string "health"
    t.float "cpu_usage"
    t.float "memory_usage"
    t.json "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_type", "service_id"], name: "index_service_states_on_service"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone_no"
    t.boolean "wizard", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_no"], name: "index_users_on_phone_no", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variables", charset: "utf8mb3", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.boolean "secret", default: false, null: false
    t.string "key", null: false
    t.text "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id", "key"], name: "index_variables_on_owner_type_and_owner_id_and_key", unique: true
    t.index ["owner_type", "owner_id"], name: "index_variables_on_owner"
  end

  create_table "version_control_accounts", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "organization_id"
    t.string "type", null: false
    t.string "token"
    t.string "webhook_id"
    t.json "requested_scopes"
    t.json "granted_scopes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "type"], name: "index_version_control_accounts_on_organization_id_and_type", unique: true
    t.index ["organization_id"], name: "index_version_control_accounts_on_organization_id"
    t.index ["webhook_id"], name: "index_version_control_accounts_on_webhook_id", unique: true
  end

end
