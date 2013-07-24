class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :when
      t.references :creator

      t.timestamps
    end
  end
end
