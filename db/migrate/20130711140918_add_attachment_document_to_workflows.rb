class AddAttachmentDocumentToWorkflows < ActiveRecord::Migration
  def self.up
    change_table :workflows do |t|
      t.attachment :document
    end
  end

  def self.down
    drop_attached_file :workflows, :document
  end
end
