require 'test_helper'

class DeletingAppointmentsTest < ActionDispatch::IntegrationTest
  setup { @appointment = Appointment.create!(first_name: "matt",
                                             last_name: "wayne",
                                             date: "09/19/16",
                                             start_time: "11:00",
                                             end_time: "11:05") }

  test "deletes appointment" do
    delete "/appointments/#{@appointment.id}"

    assert_equal 204, response.status
  end
end
