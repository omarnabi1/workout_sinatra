class Workout < ActiveRecord::Base
    belongs_to :user
    validates :name, :duration, :notes, presence: true
end