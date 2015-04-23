class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :body
      t.string :type
      t.string :location
      t.integer :day
      t.integer :month
      t.integer :year

      t.timestamps null: false
    end
  end
end
