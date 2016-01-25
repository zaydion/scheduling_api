require 'test_helper'

class ListingAppointmentsTest < ActionDispatch::IntegrationTest

  setup { host! 'api.example.com' }

  test 'returns list of all appointments' do
    get '/appointments'
    assert_equal 200, response.status
    refute_empty response.body
  end

  test 'returns appointments in JSON' do
    get '/appointments', {}, { 'Accept' => Mime::JSON }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test 'returns appointments filtered by start_time' do
    appointment_a = Appointment.create!(first_name: "matt",
                                        last_name: "wayne",
                                        start_time: "3016-12-13 05:30:00",
                                        end_time: "3016-12-13 05:35:00",
                                        comment: "excellent patient")

    appointment_b = Appointment.create!(first_name: "carl",
                                        last_name: "kramer",
                                        start_time: "3016-11-15 04:00:00",
                                        end_time: "3016-11-15 04:05:00",
                                        comment: "excellent patient")

    get "/appointments?start_time=3016-12-13%2005:30"
    assert_equal 200, response.status

    appointments = json(response.body)
    names = appointments.collect { |appointment| appointment[:last_name] }
    assert_includes names, "wayne"
    refute_includes names, "kramer"
  end

  test 'returns appointment by end_time filter' do
    appointment_a = Appointment.create!(first_name: "matt",
                                        last_name: "wayne",
                                        start_time: "3016-12-13 03:30:00",
                                        end_time: "3016-12-13 03:35:00",
                                        comment: "excellent patient")

    appointment_b = Appointment.create!(first_name: "carl",
                                        last_name: "kramer",
                                        start_time: "3016-12-13 05:30:00",
                                        end_time: "3016-12-13 05:35:00",
                                        comment: "excellent patient")

    get "/appointments?end_time=3016-12-13%2005:35:00"
    assert_equal 200, response.status

    appointments = json(response.body)
    names = appointments.collect { |appointment| appointment[:last_name] }
    assert_includes names, "kramer"
    refute_includes names, "wayne"
  end
end










