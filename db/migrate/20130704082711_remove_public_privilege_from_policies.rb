class RemovePublicPrivilegeFromPolicies < ActiveRecord::Migration
  def change
    change_table :policies do |t|
      t.remove :public_privilege
    end
  end
end
