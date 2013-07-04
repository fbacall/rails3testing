class CreateWorkflows < ActiveRecord::Migration
  def change
    create_table :workflows do |t|
      t.string :title
      t.text :description
      t.references :author
      t.references :content_blob

      t.timestamps
    end
  end
end
