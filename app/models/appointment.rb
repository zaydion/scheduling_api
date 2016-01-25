class Appointment < ActiveRecord::Base
  validates :first_name, :last_name, :start_time, :end_time, presence: true
  # validate :future_appointment


  # def future_appointment(appointment)
  #   @appointment = Appointment.find(params[:id])

  #   if @appointment.start_time > Time.zone.now
  #     @appointment
  #   else
  #     return false
  #   end
  # end
end
