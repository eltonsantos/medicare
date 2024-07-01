class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.string :name
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
