require 'test_helper'

class DeletingAppointmentsTest < ActionDispatch::IntegrationTest
  setup { @appointment = Appointment.create!(first_name: "matt",
                                             last_name: "wayne",
                                             start_time: "3016-12-13 05:30:00",
                                             end_time: "3016-12-13 05:35:00",
                                             comment: "excellent patient") }

  test "deletes appointment" do
    delete "/appointments/#{@appointment.id}"

    assert_equal 204, response.status
  end
end
