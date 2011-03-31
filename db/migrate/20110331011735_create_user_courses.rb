class CreateUserCourses < ActiveRecord::Migration
  def self.up
    create_table :user_courses do |t|
      t.references :user
      t.references :course
      t.string :year
      t.integer :confidence

      t.timestamps
    end
  end

  def self.down
    drop_table :user_courses
  end
end
