class AppointmentsController < ApplicationController

  def index
    appointments = Appointment.all
    render json: appointments, status: 200
  end

  def create
    appointments = Appointment.new(appointment_params)

    if appointment.save
      render json: appointment, status: 201, location: appointment
    end
  end

  private
  def appointment_params
    params.require(:appointment).permit(:first_name, :last_name, :date, :start_time, :end_time)
  end
end

