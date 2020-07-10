class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |workout|
      workout.string :name
      workout.string :notes
      workout.integer :duration
      workout.integer :user_id
      workout.timestamps null: false
    end

  end
end
