class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :crypted_password
      t.string :salt
      t.string :activation_code
      t.datetime :activated_at
      t.string :remember_token
      t.datetime :remember_token_expires_at

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
