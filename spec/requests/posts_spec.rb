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

  it 'should return status code 400 if sortBy parameter is not valid' do
    get '/api/posts/science/date'
    expect(response.code).to eq("400")
  end

  it 'should return correct error message if sortBy parameter is not valid' do
    get '/api/posts/science/date'
    expect(response.body).to eq({error:"sortBy parameter is invalid"}.to_json)
  end

  it 'should return status code 400 if direction parameter is not valid' do
    get '/api/posts/science/likes/horizontal'
    expect(response.code).to eq("400")
  end

  it 'should return correct error message if direction parameter is not valid' do
    get '/api/posts/science/likes/horizontal'
    expect(response.body).to eq({error:"direction parameter is invalid"}.to_json)
  end

  it 'should return status code 200 when all query parameters are present' do
    get '/api/posts/science,tech/likes/asc'
    expect(response.code).to eq("200")
  end

  # single tag
  it 'should return json object with posts containing tag specified when one tag parameter passed' do
    get '/api/posts/tech'
    tags_per_post= JSON.parse(response.body)["posts"].map {|post| post["tags"]}
    includes= true
    tags_per_post.each {|tag_arr| if !tag_arr.include? "tech"
      includes=false
      end }
    expect(includes).to eq(true)
  end

  it 'should return posts sorted by sortBy parameter in ascending order when specified if one tag is specified' do
    get '/api/posts/science/id/asc'
    sortBy_values= JSON.parse(response.body)["posts"].map {|post| post["id"]}
    expect(sortBy_values).to eq(sortBy_values.sort)
  end

  it 'should return posts sorted by sortBy parameter in descending order when specified if one tag is specified' do
    get '/api/posts/science/reads/desc'
    sortBy_values= JSON.parse(response.body)["posts"].map {|post| post["reads"]}
    expect(sortBy_values).to eq(sortBy_values.sort.reverse)
  end

  it 'should return posts sorted by sortBy parameter in ascending order if direction unspecified if one tag is specified' do
    get '/api/posts/science/likes'
    sortBy_values= JSON.parse(response.body)["posts"].map {|post| post["likes"]}
    expect(sortBy_values).to eq(sortBy_values.sort)
  end

  # multiple tags
  it 'should return json object with posts containing tags specified when multiple tags are passed' do
    get '/api/posts/science,tech'
    tags_per_post= JSON.parse(response.body)["posts"].map {|post| post["tags"]}

    includes= true
    tags_per_post.each {|tag_arr| 
    if !(tag_arr.include?("science") || tag_arr.include?("tech"))
      includes=false
      end
    }
    expect(includes).to eq(true)
  end

  it 'should return posts sorted by sortBy parameter in ascending order when specified and multiple tags are passed' do
    get '/api/posts/science,tech/popularity/asc'
    sortBy_values= JSON.parse(response.body)["posts"].map {|post| post["popularity"]}
    expect(sortBy_values).to eq(sortBy_values.sort)
  end

  it 'should return posts sorted by sortBy parameter in descending order when specified and multiple tags are passed' do
    get '/api/posts/science,tech/id/desc'
    sortBy_values= JSON.parse(response.body)["posts"].map {|post| post["id"]}
    expect(sortBy_values).to eq(sortBy_values.sort.reverse)
  end

  it 'should return posts sorted by sortBy parameter in ascending order if direction unspecified and multiple tags are passed' do
    get '/api/posts/science,tech/reads/'
    sortBy_values= JSON.parse(response.body)["posts"].map {|post| post["reads"]}
    expect(sortBy_values).to eq(sortBy_values.sort)
  end

  it 'should return non-duplicate posts when multiple tags parameters specified' do
    get '/api/posts/science,tech/likes/asc'
    ids= JSON.parse(response.body)["posts"].map {|post| post["id"]}
    expect(ids).to eq(ids.uniq)
  end
end