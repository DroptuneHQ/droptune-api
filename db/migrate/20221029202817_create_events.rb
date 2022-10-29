class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :kind
      t.bigint :kind_id
      t.belongs_to :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
