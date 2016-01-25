require 'test_helper'

class CreatingAppointmentsTest < ActionDispatch::IntegrationTest
    setup { @appointment = Appointment.create!(first_name: "matt",
                                             last_name: "wayne",
                                             start_time: "3016-12-13 05:30:00",
                                             end_time: "3016-12-13 05:35:00",
                                             comment: "excellent patient") }

  test 'create appointments' do
    post '/appointments',
    { appointment:
      { first_name: 'jose', last_name: 'cartagena', start_time: "3016-12-13 05:30:00",
        end_time: "3016-12-13 05:35:00", comment: "Nice attitude"}
      }.to_json,
    { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    appointment = json(response.body)
    assert_equal appointment_url(appointment[:id]), response.location
  end

  test 'invalid appointments are not created' do
    post '/appointments',
    { appointment:
      { first_name: nil }
      }.to_json,
    { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal Mime::JSON, response.content_type
    assert_equal 422, response.status
  end
end

