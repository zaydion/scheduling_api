class Appointment < ActiveRecord::Base
  validates :first_name, :last_name, :date, :start_time, :end_time, presence: true

end
