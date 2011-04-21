class AddDetailsToCourse < ActiveRecord::Migration
  def self.up
    change_table :user_courses do |t|
      t.text :notes
    end
  end

  def self.down
    change_table :user_courses do |t|
      t.remove :notes
    end
  end
end
