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
                                      date: "09/19/16",
                                      start_time: "11:00",
                                      end_time: "11:05")

    appointment_b = Appointment.create!(first_name: "john",
                                      last_name: "kramer",
                                      date: "09/19/16",
                                      start_time: "12:00",
                                      end_time: "12:05")

    get "/appointments?start_time=11:00"
    assert_equal 200, response.status

    appointments = json(response.body)
    names = appointments.collect { |appointment| appointment[:last_name] }
    assert_includes names, "wayne"
    refute_includes names, "kramer"
  end

  test 'returns appointment by end_time filter' do
    appointment_a = Appointment.create!(first_name: "matt",
                                      last_name: "wayne",
                                      date: "09/19/16",
                                      start_time: "11:00",
                                      end_time: "11:05")

    appointment_b = Appointment.create!(first_name: "john",
                                      last_name: "kramer",
                                      date: "09/19/16",
                                      start_time: "12:00",
                                      end_time: "12:05")

    get '/appointments?end_time=12:05'
    assert_equal 200, response.status

    appointments = json(response.body)
    names = appointments.collect { |appointment| appointment[:last_name] }
    assert_includes names, "kramer"
    refute_includes names, "wayne"
  end

  test 'returns appointments by date filter' do
    appointment_a = Appointment.create!(first_name: "matt",
                                      last_name: "wayne",
                                      date: "10/19/16",
                                      start_time: "12:00",
                                      end_time: "12:05")

    appointment_b = Appointment.create!(first_name: "john",
                                      last_name: "kramer",
                                      date: "09/19/16",
                                      start_time: "12:00",
                                      end_time: "12:05")

    get '/appointments?date=10/19/16'
    assert_equal 200, response.status

    appointments = json(response.body)
    names = appointments.collect { |appointment| appointment[:last_name] }
    assert_includes names, "wayne"
    refute_includes names, "kramer"
  end
end










