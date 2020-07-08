class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.string :workout_type
      t.integer :workout_duration
      t.string :workout_notes
      t.timestamps null: false
    end

  end
end
