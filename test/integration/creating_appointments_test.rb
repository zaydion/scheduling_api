require 'test_helper'

class CreatingAppointmentsTest < ActionDispatch::IntegrationTest

  test 'create appointments' do
    post '/appointments',
    { appointment:
      { first_name: 'jose', last_name: 'cartagena', date: '2/19/16',
       start_time: '14:00', end_time: '14:05' }
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
      { first_name: nil, last_name: 'cartagena', date: nil,
       start_time: '14:00', end_time: '14:05' }
      }.to_json,
    { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal Mime::JSON, response.content_type
    assert_equal 422, response.status
  end
end

