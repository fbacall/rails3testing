class CreateContentBlobs < ActiveRecord::Migration
  def change
    create_table :content_blobs do |t|
      t.binary :data

      t.timestamps
    end
  end
end
