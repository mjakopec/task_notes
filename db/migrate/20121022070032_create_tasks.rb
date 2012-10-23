class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :email
      t.string :todo
      t.string :priority

      t.timestamps
    end
  end
end
