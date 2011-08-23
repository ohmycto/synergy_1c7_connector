class Add1c7ConnectorFields < ActiveRecord::Migration
  def self.up
    add_column :products, :code_1c, :string
    add_column :taxons, :code_1c, :string
  end

  def self.down
    remove_column :taxons, :code_1c
    remove_column :products, :code_1c
  end
end