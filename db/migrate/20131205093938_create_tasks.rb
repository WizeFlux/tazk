class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :text
      t.string :state
      t.belongs_to :stage

      t.timestamps
    end
  end
end
