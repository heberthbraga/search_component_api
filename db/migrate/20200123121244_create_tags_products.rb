class CreateTagsProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :tags_products do |t|
      t.references :product, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
