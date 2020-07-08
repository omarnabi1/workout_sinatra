class Workout < ActiveRecord::Base
    belongs_to :user
    validates :name, :duration, :calories_burned, presence: true
end