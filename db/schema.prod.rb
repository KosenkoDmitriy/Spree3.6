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

ActiveRecord::Schema.define(:version => 20180616161953) do

  create_table "blog_rolls", :force => true do |t|
    t.string "summary"
    t.date   "published_date"
    t.string "title"
    t.string "url"
    t.string "category"
    t.string "guid"
  end

  add_index "blog_rolls", ["guid"], :name => "index_blog_rolls_on_guid", :unique => true

  create_table "dynamic_data", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag"
    t.text     "data"
  end

  create_table "facebook_messages", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fb_id"
    t.string   "fb_type"
    t.datetime "fb_created_at"
    t.string   "from"
    t.string   "from_fb_id"
    t.string   "application"
    t.string   "application_fb_id"
    t.string   "to"
    t.string   "to_fb_id"
    t.string   "message"
    t.string   "link"
    t.string   "picture"
  end

  create_table "features", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enabled",                 :default => false
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.integer  "product_id"
    t.string   "attachment_content_type"
    t.string   "attachment_file_name"
    t.integer  "attachment_size"
    t.datetime "attachment_updated_at"
    t.integer  "attachment_width"
    t.integer  "attachment_height"
    t.string   "shop_enabled"
  end

  create_table "galleries", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poster_id"
    t.string   "title"
    t.text     "description"
    t.boolean  "enabled",     :default => true
    t.string   "category"
  end

  create_table "hsbc_cpi_transactions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "order_hash"
    t.float    "purchase_amount"
    t.string   "purchase_currency"
    t.string   "transaction_mode"
    t.string   "transaction_type"
    t.string   "cpi_direct_result_url"
    t.string   "cpi_return_url"
    t.string   "store_front_id"
    t.integer  "user_id"
    t.string   "order_description"
    t.string   "cpi_results_code"
    t.string   "cpi_results_order_hash"
    t.datetime "processed_at"
    t.text     "cpi_sent_params"
    t.text     "cpi_callback_params"
    t.text     "cpi_return_params"
  end

  create_table "insta_photos", :force => true do |t|
    t.string   "insta_id"
    t.datetime "uploaded_at"
    t.string   "title"
    t.string   "link"
    t.string   "thumb"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "offer_images", :force => true do |t|
    t.string   "caption"
    t.integer  "offer_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "offers", :force => true do |t|
    t.boolean  "enabled"
    t.string   "title"
    t.string   "location"
    t.text     "description"
    t.text     "offer"
    t.boolean  "view_by_appt"
    t.string   "contact_email"
    t.string   "contact_tel"
    t.string   "website"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "postcode"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "offers", ["slug"], :name => "index_offers_on_slug"

  create_table "photos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gallery_id"
    t.string   "caption"
    t.string   "file_content_type"
    t.string   "file_file_name"
    t.integer  "file_size"
    t.datetime "file_updated_at"
    t.integer  "file_width"
    t.integer  "file_height"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "post_type"
    t.date     "published_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body_extended"
    t.string   "permalink"
  end

  create_table "spree_activators", :force => true do |t|
    t.string   "description"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "starts_at"
    t.string   "name"
    t.string   "event_name"
    t.string   "type"
    t.integer  "usage_limit"
    t.string   "match_policy", :default => "all"
    t.string   "code"
    t.boolean  "advertise",    :default => false
    t.string   "path"
  end

  create_table "spree_addresses", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "zipcode"
    t.integer  "country_id"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state_name"
    t.string   "alternative_phone"
    t.string   "company"
    t.string   "vat"
  end

  add_index "spree_addresses", ["firstname"], :name => "index_addresses_on_firstname"
  add_index "spree_addresses", ["lastname"], :name => "index_addresses_on_lastname"

  create_table "spree_adjustments", :force => true do |t|
    t.integer  "adjustable_id"
    t.decimal  "amount",          :precision => 10, :scale => 2
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "source_id"
    t.string   "source_type"
    t.boolean  "mandatory"
    t.integer  "originator_id"
    t.string   "originator_type"
    t.boolean  "eligible",                                       :default => true
    t.string   "adjustable_type"
    t.string   "state"
  end

  add_index "spree_adjustments", ["adjustable_id"], :name => "index_adjustments_on_order_id"
  add_index "spree_adjustments", ["source_type", "source_id"], :name => "index_spree_adjustments_on_source_type_and_source_id"

  create_table "spree_assets", :force => true do |t|
    t.integer  "viewable_id"
    t.string   "viewable_type",           :limit => 50
    t.string   "attachment_content_type"
    t.string   "attachment_file_name"
    t.integer  "attachment_file_size"
    t.integer  "position"
    t.string   "type",                    :limit => 75
    t.datetime "attachment_updated_at"
    t.integer  "attachment_width"
    t.integer  "attachment_height"
    t.text     "alt"
  end

  add_index "spree_assets", ["viewable_id"], :name => "index_assets_on_viewable_id"
  add_index "spree_assets", ["viewable_type", "type"], :name => "index_assets_on_viewable_type_and_type"

  create_table "spree_calculators", :force => true do |t|
    t.string   "type"
    t.integer  "calculable_id",   :null => false
    t.string   "calculable_type", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_configurations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",       :limit => 50
  end

  add_index "spree_configurations", ["name", "type"], :name => "index_configurations_on_name_and_type"

  create_table "spree_countries", :force => true do |t|
    t.string  "iso_name"
    t.string  "iso"
    t.string  "name"
    t.string  "iso3"
    t.integer "numcode"
    t.boolean "states_required", :default => false
  end

  create_table "spree_credit_cards", :force => true do |t|
    t.string   "month"
    t.string   "year"
    t.string   "cc_type"
    t.string   "last_digits"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
    t.string   "gateway_customer_profile_id"
    t.string   "gateway_payment_profile_id"
  end

  create_table "spree_gateways", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.text     "description"
    t.boolean  "active",      :default => true
    t.string   "environment", :default => "development"
    t.string   "server",      :default => "test"
    t.boolean  "test_mode",   :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_inventory_units", :force => true do |t|
    t.integer  "variant_id"
    t.integer  "order_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shipment_id"
    t.integer  "return_authorization_id"
    t.boolean  "pending",                 :default => true
  end

  add_index "spree_inventory_units", ["order_id"], :name => "index_inventory_units_on_order_id"
  add_index "spree_inventory_units", ["shipment_id"], :name => "index_inventory_units_on_shipment_id"
  add_index "spree_inventory_units", ["variant_id"], :name => "index_inventory_units_on_variant_id"

  create_table "spree_line_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "variant_id"
    t.integer  "quantity",                                       :null => false
    t.decimal  "price",           :precision => 18, :scale => 6, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency"
    t.decimal  "cost_price",      :precision => 18, :scale => 6
    t.integer  "tax_category_id"
  end

  add_index "spree_line_items", ["order_id"], :name => "index_line_items_on_order_id"
  add_index "spree_line_items", ["variant_id"], :name => "index_line_items_on_variant_id"

  create_table "spree_log_entries", :force => true do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_option_types", :force => true do |t|
    t.string   "name",         :limit => 100
    t.string   "presentation", :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",                    :default => 0, :null => false
  end

  create_table "spree_option_types_prototypes", :id => false, :force => true do |t|
    t.integer "prototype_id"
    t.integer "option_type_id"
  end

  create_table "spree_option_values", :force => true do |t|
    t.integer  "option_type_id"
    t.string   "name"
    t.integer  "position"
    t.string   "presentation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_option_values_variants", :id => false, :force => true do |t|
    t.integer "variant_id"
    t.integer "option_value_id"
  end

  add_index "spree_option_values_variants", ["variant_id", "option_value_id"], :name => "index_option_values_variants_on_variant_id_and_option_value_id"
  add_index "spree_option_values_variants", ["variant_id"], :name => "index_option_values_variants_on_variant_id"

  create_table "spree_orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "number",               :limit => 32
    t.decimal  "item_total",                         :precision => 10, :scale => 2, :default => 0.0,     :null => false
    t.decimal  "total",                              :precision => 10, :scale => 2, :default => 0.0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.decimal  "adjustment_total",                   :precision => 10, :scale => 2, :default => 0.0,     :null => false
    t.datetime "completed_at"
    t.integer  "bill_address_id"
    t.integer  "ship_address_id"
    t.decimal  "payment_total",                      :precision => 10, :scale => 2, :default => 0.0
    t.integer  "shipping_method_id"
    t.string   "shipment_state"
    t.string   "payment_state"
    t.string   "email"
    t.text     "special_instructions"
    t.boolean  "agreed_to_terms"
    t.string   "currency"
    t.string   "last_ip_address"
    t.integer  "created_by_id"
    t.string   "channel",                                                           :default => "spree"
  end

  add_index "spree_orders", ["completed_at"], :name => "index_spree_orders_on_completed_at"
  add_index "spree_orders", ["number"], :name => "index_orders_on_number"
  add_index "spree_orders", ["user_id", "created_by_id"], :name => "index_spree_orders_on_user_id_and_created_by_id"

  create_table "spree_pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "slug"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.boolean  "show_in_header",           :default => false, :null => false
    t.boolean  "show_in_footer",           :default => false, :null => false
    t.string   "foreign_link"
    t.integer  "position",                 :default => 1,     :null => false
    t.boolean  "visible",                  :default => true
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "layout"
    t.boolean  "show_in_sidebar",          :default => false, :null => false
    t.string   "meta_title"
    t.boolean  "render_layout_as_partial", :default => false
  end

  add_index "spree_pages", ["slug"], :name => "index_spree_pages_on_slug"

  create_table "spree_payment_methods", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.text     "description"
    t.boolean  "active",      :default => true
    t.string   "environment", :default => "development"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "display_on"
  end

  create_table "spree_payments", :force => true do |t|
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount",               :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "payment_method_id"
    t.string   "state"
    t.string   "response_code"
    t.string   "avs_response"
    t.string   "identifier"
    t.string   "cvv_response_code"
    t.string   "cvv_response_message"
  end

  add_index "spree_payments", ["order_id"], :name => "index_spree_payments_on_order_id"

  create_table "spree_paypal_accounts", :force => true do |t|
    t.string "email"
    t.string "payer_id"
    t.string "payer_country"
    t.string "payer_status"
  end

  create_table "spree_pending_promotions", :force => true do |t|
    t.integer "user_id"
    t.integer "promotion_id"
  end

  add_index "spree_pending_promotions", ["promotion_id"], :name => "index_spree_pending_promotions_on_promotion_id"
  add_index "spree_pending_promotions", ["user_id"], :name => "index_spree_pending_promotions_on_user_id"

  create_table "spree_preferences", :force => true do |t|
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
    t.string   "value_type"
  end

  add_index "spree_preferences", ["key"], :name => "index_spree_preferences_on_key", :unique => true

  create_table "spree_prices", :force => true do |t|
    t.integer "variant_id",                                :null => false
    t.decimal "amount",     :precision => 18, :scale => 6
    t.string  "currency"
  end

  add_index "spree_prices", ["variant_id", "currency"], :name => "index_spree_prices_on_variant_id_and_currency"

  create_table "spree_product_groups", :force => true do |t|
    t.string "name"
    t.string "permalink"
    t.string "order"
  end

  add_index "spree_product_groups", ["name"], :name => "index_product_groups_on_name"
  add_index "spree_product_groups", ["permalink"], :name => "index_product_groups_on_permalink"

  create_table "spree_product_groups_products", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "product_group_id"
  end

  create_table "spree_product_option_types", :force => true do |t|
    t.integer  "product_id"
    t.integer  "option_type_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_product_properties", :force => true do |t|
    t.integer  "product_id"
    t.integer  "property_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",    :default => 0
  end

  add_index "spree_product_properties", ["product_id"], :name => "index_product_properties_on_product_id"

  create_table "spree_product_scopes", :force => true do |t|
    t.integer "product_group_id"
    t.string  "name"
    t.text    "arguments"
  end

  add_index "spree_product_scopes", ["name"], :name => "index_product_scopes_on_name"
  add_index "spree_product_scopes", ["product_group_id"], :name => "index_product_scopes_on_product_group_id"

  create_table "spree_products", :force => true do |t|
    t.string   "name",                  :default => "", :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.datetime "available_on"
    t.integer  "tax_category_id"
    t.integer  "shipping_category_id"
    t.datetime "deleted_at"
    t.text     "meta_description"
    t.string   "meta_keywords"
    t.text     "description_details"
    t.text     "description_technique"
  end

  add_index "spree_products", ["available_on"], :name => "index_products_on_available_on"
  add_index "spree_products", ["deleted_at"], :name => "index_products_on_deleted_at"
  add_index "spree_products", ["name"], :name => "index_products_on_name"
  add_index "spree_products", ["permalink"], :name => "index_products_on_permalink"
  add_index "spree_products", ["permalink"], :name => "permalink_idx_unique", :unique => true
  add_index "spree_products", ["permalink"], :name => "unique_products_on_permalink", :unique => true

  create_table "spree_products_promotion_rules", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "promotion_rule_id"
  end

  add_index "spree_products_promotion_rules", ["product_id"], :name => "index_products_promotion_rules_on_product_id"
  add_index "spree_products_promotion_rules", ["promotion_rule_id"], :name => "index_products_promotion_rules_on_promotion_rule_id"

  create_table "spree_products_taxons", :force => true do |t|
    t.integer "product_id"
    t.integer "taxon_id"
  end

  add_index "spree_products_taxons", ["product_id"], :name => "index_products_taxons_on_product_id"
  add_index "spree_products_taxons", ["taxon_id"], :name => "index_products_taxons_on_taxon_id"

  create_table "spree_promotion_action_line_items", :force => true do |t|
    t.integer "promotion_action_id"
    t.integer "variant_id"
    t.integer "quantity",            :default => 1
  end

  create_table "spree_promotion_actions", :force => true do |t|
    t.integer "activator_id"
    t.integer "position"
    t.string  "type"
  end

  create_table "spree_promotion_rules", :force => true do |t|
    t.integer  "activator_id"
    t.integer  "user_id"
    t.integer  "product_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "spree_promotion_rules", ["product_group_id"], :name => "index_promotion_rules_on_product_group_id"
  add_index "spree_promotion_rules", ["user_id"], :name => "index_promotion_rules_on_user_id"

  create_table "spree_promotion_rules_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "promotion_rule_id"
  end

  add_index "spree_promotion_rules_users", ["promotion_rule_id"], :name => "index_promotion_rules_users_on_promotion_rule_id"
  add_index "spree_promotion_rules_users", ["user_id"], :name => "index_promotion_rules_users_on_user_id"

  create_table "spree_properties", :force => true do |t|
    t.string   "name"
    t.string   "presentation", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_properties_prototypes", :id => false, :force => true do |t|
    t.integer "prototype_id"
    t.integer "property_id"
  end

  create_table "spree_prototypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_return_authorizations", :force => true do |t|
    t.string   "number"
    t.decimal  "amount",            :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.integer  "order_id"
    t.text     "reason"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock_location_id"
  end

  create_table "spree_roles", :force => true do |t|
    t.string "name"
  end

  create_table "spree_roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "spree_roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "spree_roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "spree_shipments", :force => true do |t|
    t.integer  "order_id"
    t.string   "tracking"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number"
    t.decimal  "cost",              :precision => 8, :scale => 2
    t.datetime "shipped_at"
    t.integer  "address_id"
    t.string   "state"
    t.integer  "stock_location_id"
  end

  add_index "spree_shipments", ["number"], :name => "index_shipments_on_number"
  add_index "spree_shipments", ["order_id"], :name => "index_spree_shipments_on_order_id"

  create_table "spree_shipping_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_shipping_method_categories", :force => true do |t|
    t.integer  "shipping_method_id",   :null => false
    t.integer  "shipping_category_id", :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "spree_shipping_method_categories", ["shipping_category_id"], :name => "index_spree_shipping_method_categories_on_shipping_category_id"
  add_index "spree_shipping_method_categories", ["shipping_method_id"], :name => "index_spree_shipping_method_categories_on_shipping_method_id"

  create_table "spree_shipping_methods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_on"
    t.datetime "deleted_at"
    t.string   "tracking_url"
    t.string   "admin_name"
  end

  create_table "spree_shipping_methods_zones", :primary_key => "pk", :force => true do |t|
    t.integer "shipping_method_id"
    t.integer "zone_id"
  end

  create_table "spree_shipping_rates", :force => true do |t|
    t.integer  "shipment_id"
    t.integer  "shipping_method_id"
    t.boolean  "selected",                                         :default => false
    t.decimal  "cost",               :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
  end

  add_index "spree_shipping_rates", ["shipment_id", "shipping_method_id"], :name => "spree_shipping_rates_join_index", :unique => true

  create_table "spree_skrill_transactions", :force => true do |t|
    t.string   "email"
    t.float    "amount"
    t.string   "currency"
    t.integer  "transaction_id"
    t.integer  "customer_id"
    t.string   "payment_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "spree_state_changes", :force => true do |t|
    t.integer  "stateful_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "previous_state"
    t.string   "stateful_type"
    t.string   "next_state"
  end

  create_table "spree_states", :force => true do |t|
    t.string  "name"
    t.string  "abbr"
    t.integer "country_id"
  end

  create_table "spree_stock_items", :force => true do |t|
    t.integer  "stock_location_id"
    t.integer  "variant_id"
    t.integer  "count_on_hand",     :default => 0,     :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.datetime "deleted_at"
    t.boolean  "backorderable",     :default => false
  end

  add_index "spree_stock_items", ["stock_location_id", "variant_id"], :name => "stock_item_by_loc_and_var_id"
  add_index "spree_stock_items", ["stock_location_id"], :name => "index_spree_stock_items_on_stock_location_id"

  create_table "spree_stock_locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "state_name"
    t.integer  "country_id"
    t.string   "zipcode"
    t.string   "phone"
    t.boolean  "active",                 :default => true
    t.boolean  "backorderable_default",  :default => false
    t.boolean  "propagate_all_variants", :default => true
    t.string   "admin_name"
  end

  create_table "spree_stock_movements", :force => true do |t|
    t.integer  "stock_item_id"
    t.integer  "quantity",        :default => 0
    t.string   "action"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "originator_id"
    t.string   "originator_type"
  end

  add_index "spree_stock_movements", ["stock_item_id"], :name => "index_spree_stock_movements_on_stock_item_id"

  create_table "spree_stock_transfers", :force => true do |t|
    t.string   "type"
    t.string   "reference"
    t.integer  "source_location_id"
    t.integer  "destination_location_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "number"
  end

  add_index "spree_stock_transfers", ["destination_location_id"], :name => "index_spree_stock_transfers_on_destination_location_id"
  add_index "spree_stock_transfers", ["number"], :name => "index_spree_stock_transfers_on_number"
  add_index "spree_stock_transfers", ["source_location_id"], :name => "index_spree_stock_transfers_on_source_location_id"

  create_table "spree_tax_categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_default",  :default => false
    t.datetime "deleted_at"
  end

  create_table "spree_tax_rates", :force => true do |t|
    t.integer  "zone_id"
    t.decimal  "amount",             :precision => 8, :scale => 5
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tax_category_id"
    t.boolean  "included_in_price",                                :default => false
    t.string   "name"
    t.boolean  "show_rate_in_label",                               :default => true
    t.datetime "deleted_at"
  end

  create_table "spree_taxonomies", :force => true do |t|
    t.string   "name",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   :default => 0
  end

  create_table "spree_taxons", :force => true do |t|
    t.integer  "taxonomy_id",                      :null => false
    t.integer  "parent_id"
    t.integer  "position",          :default => 0
    t.string   "name",                             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.text     "description"
    t.string   "meta_title"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.integer  "depth"
  end

  add_index "spree_taxons", ["parent_id"], :name => "index_taxons_on_parent_id"
  add_index "spree_taxons", ["permalink"], :name => "index_taxons_on_permalink"
  add_index "spree_taxons", ["taxonomy_id"], :name => "index_taxons_on_taxonomy_id"

  create_table "spree_tokenized_permissions", :force => true do |t|
    t.integer  "permissable_id"
    t.string   "permissable_type"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_tokenized_permissions", ["permissable_id", "permissable_type"], :name => "index_tokenized_name_and_type"

  create_table "spree_trackers", :force => true do |t|
    t.string   "environment"
    t.string   "analytics_id"
    t.boolean  "active",       :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "persistence_token"
    t.string   "reset_password_token"
    t.string   "perishable_token"
    t.integer  "sign_in_count",                        :default => 0, :null => false
    t.integer  "failed_attempts",                      :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "login"
    t.integer  "ship_address_id"
    t.integer  "bill_address_id"
    t.string   "authentication_token"
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string   "spree_api_key",          :limit => 48
  end

  add_index "spree_users", ["email"], :name => "email_idx_unique", :unique => true
  add_index "spree_users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "spree_users", ["spree_api_key"], :name => "index_spree_users_on_spree_api_key"

  create_table "spree_variants", :force => true do |t|
    t.integer  "product_id"
    t.string   "sku",                                            :default => "",    :null => false
    t.decimal  "weight",          :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "height",          :precision => 8,  :scale => 2
    t.decimal  "width",           :precision => 8,  :scale => 2
    t.decimal  "depth",           :precision => 8,  :scale => 2
    t.datetime "deleted_at"
    t.boolean  "is_master",                                      :default => false
    t.decimal  "cost_price",      :precision => 8,  :scale => 2
    t.string   "cost_currency"
    t.integer  "position"
    t.decimal  "main_price",      :precision => 18, :scale => 6
    t.decimal  "sale_price",      :precision => 18, :scale => 6
    t.boolean  "track_inventory",                                :default => true
  end

  add_index "spree_variants", ["product_id"], :name => "index_variants_on_product_id"
  add_index "spree_variants", ["sku"], :name => "index_spree_variants_on_sku"

  create_table "spree_zone_members", :force => true do |t|
    t.integer  "zone_id"
    t.integer  "zoneable_id"
    t.string   "zoneable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spree_zones", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default_tax",        :default => false
    t.integer  "zone_members_count", :default => 0
  end

  create_table "testimonials", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "body"
    t.boolean  "enabled"
  end

  create_table "twitter_messages", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_id"
    t.datetime "twitter_created_at"
    t.string   "from"
    t.string   "from_image"
    t.string   "message"
    t.string   "link"
  end

end
