require 'rails_helper'

describe "ping route", :type => :request do
  
  it 'should return the correct body' do
    get '/api/ping'
    expect(response.body).to eq({success: "true"}.to_json)
  end

  it 'returns status code 200 when route is correct' do
    get '/api/ping'
    expect(response.code).to eq("200")
  end

  it 'returns status code 404 when route is incorrect' do
    get '/api/pin'
    expect(response.code).to eq("404")
  end
end