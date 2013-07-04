class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :user, :group
      t.boolean :admin
      t.timestamps
    end
    add_index :memberships, [:user_id, :group_id]
    add_index :memberships, [:group_id, :user_id]
  end
end
