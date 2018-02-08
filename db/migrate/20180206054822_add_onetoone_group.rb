class AddOnetooneGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :onetoone, :integer
  end
end
