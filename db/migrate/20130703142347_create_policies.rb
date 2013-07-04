class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.string :title
      t.integer :public_privilege

      t.timestamps
    end
  end
end
