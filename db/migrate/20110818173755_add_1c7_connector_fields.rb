class Add1c7ConnectorFields < ActiveRecord::Migration
  def self.up
    add_column :products, :code, :string
    add_column :taxons, :code, :string
  end

  def self.down
    remove_column :taxons, :code
    remove_column :products, :code
  end
end