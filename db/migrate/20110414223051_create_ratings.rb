class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.references :user_course
      t.integer :number
      t.text :comment
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
