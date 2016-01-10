class AppointmentsController < ApplicationController

  def index
    appointments = Appointment.all
    render json: appointments, status: 200
  end

  def create
    appointment = Appointment.new(appointment_params)

    if appointment.save
      render json: appointment, status: 201, location: appointment
    else
      render json: appointment.errors, status: 422
    end
  end

  private
  def appointment_params
    params.require(:appointment).permit(:first_name, :last_name, :date, :start_time, :end_time)
  end
end

