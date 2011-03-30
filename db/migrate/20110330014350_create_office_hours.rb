class CreateOfficeHours < ActiveRecord::Migration
  def self.up
    create_table :office_hours do |t|
      t.references :user_course
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.text :location_details

      t.timestamps
    end
  end

  def self.down
    drop_table :office_hours
  end
end
