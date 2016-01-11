require 'test_helper'

class UpdatingAppointmentsTest < ActionDispatch::IntegrationTest
  setup { @appointment = Appointment.create!(first_name: "matt",
                                             last_name: "wayne",
                                             date: "09/19/16",
                                             start_time: "11:00",
                                             end_time: "11:05") }

  test "updates apppointment" do
    patch "/appointments/#{@appointment.id}",
      { appointment: { first_name: "mark" } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      assert_equal 200, response.status
      assert_equal 'mark', @appointment.reload.first_name
  end

  test "does not update appointment with invalid data" do
    patch "/appointments/#{@appointment.id}",
      { appointment: { first_name: nil } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      assert_equal 422, response.status
  end
end
