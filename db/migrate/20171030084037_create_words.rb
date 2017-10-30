class CreateWords < ActiveRecord::Migration[5.1]
  def change
    create_table :words do |t|
      t.string :text
      t.belongs_to :user

      t.timestamps
    end
  end
end
