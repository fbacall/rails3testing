class RemoveContentBlobs < ActiveRecord::Migration
  def change
    change_table :workflows do |t|
      t.remove :content_blob_id
    end

    drop_table :content_blobs
  end
end
