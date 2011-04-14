class AddUserName < ActiveRecord::Migration
  def self.up
    alter_table :users do |t|
      t.string :first_name
      t.string :last_name
    end
  end

  def self.down
    alter_table :users do |t|
      t.remove :first_name
      t.remove :last_name
    end
  end
end
