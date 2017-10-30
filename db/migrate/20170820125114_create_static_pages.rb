class CreateStaticPages < ActiveRecord::Migration[5.1]
  def change
    create_table :static_pages do |t|
      t.string :slug
      t.text :content
      t.string :markup_type

      t.timestamps
    end
  end
end
