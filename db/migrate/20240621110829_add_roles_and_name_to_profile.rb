class AddRolesAndNameToProfile < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :role, :integer
    add_column :profiles, :name, :string
  end
end
