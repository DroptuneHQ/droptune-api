class CreateSources < ActiveRecord::Migration[7.0]
  def change
    create_table :sources do |t|
      t.belongs_to :artist, null: false, foreign_key: true
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
