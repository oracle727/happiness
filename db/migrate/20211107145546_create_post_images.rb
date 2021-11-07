class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
    t.integer "post_id", null: false
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_images_on_post_id"

      t.timestamps
    end
  end
end
