require 'rails_helper'

describe "posts route", :type => :request do
  it 'should return status code 200 when route is correct' do
    get '/api/posts/tech'
    expect(response.code).to eq("200")
  end

  it 'should return status code 404 when route is incorrect' do
    get '/api/post/tech'
    expect(response.code).to eq("404")
  end

  it 'should return status code 400 if tags parameter is not present' do
    get '/api/posts/'
    expect(response.code).to eq("400")
  end

  it 'should return correct error message if tags parameter is not present' do
    get '/api/posts/'
    expect(response.body).to eq({error:"Tags parameter is required"}.to_json)
  end

  it 'should return status code 200 when all query parameters are present' do
    get '/api/posts/science,tech/likes/asc'
    expect(response.code).to eq("200")
  end
end