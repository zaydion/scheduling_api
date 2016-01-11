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
    appointment = Appointment.create!(first_name: "matt",
                                      last_name: "wayne",
                                      date: "09/19/16",
                                      start_time: "11:00",
                                      end_time: "11:05")

    appointment = Appointment.create!(first_name: "john",
                                      last_name: "kramer",
                                      date: "09/19/16",
                                      start_time: "12:00",
                                      end_time: "12:05")

    get "/appointments?start_time=11:00"
    assert_equal 200, response.status

    appointments = json(response.body)
    names = appointments.collect { |appointment| appointment[:first_name] }
    assert_includes names, "matt"
    refute_includes names, "john"
  end

  # test 'returns appointment by end_time filter' do
  #   get 'appointments?end_time=#{@appointment.end_time}'

  #   assert_equal 200, response.status
  #   assert_equal Mime::JSON, response.content_type
  # end
end
