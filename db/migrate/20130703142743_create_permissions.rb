class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :policy
      t.references :for, :polymorphic => true
      t.integer :privilege
      t.timestamps
    end
  end
end
