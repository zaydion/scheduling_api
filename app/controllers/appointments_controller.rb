class AppointmentsController < ApplicationController

  def index
    appointments = Appointment.all
    if start_time = params[:start_time]
      appointments = appointments.where(start_time: start_time)
    end
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

  def update
    appointment = Appointment.find(params[:id])

    if appointment.update(appointment_params)
      render json: appointment, status: 200
    else
      render json: appointment.errors, status: 422
    end
  end

  def show
    appointment = Appointment.find(params[:id])
    render json: appointment, status: 200
  end

  def destroy
    appointment = Appointment.find(params[:id])
    appointment.destroy
    head 204
  end

  private
  def appointment_params
    params.require(:appointment).permit(:first_name,
                                        :last_name,
                                        :date,
                                        :start_time,
                                        :end_time)
  end
end

