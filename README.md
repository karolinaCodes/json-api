# Description

This back-end application was built for the 'Ruby Back-end Assessment' from Hatchways.

This API returns a JSON object with an array of blogs posts fetched from the hatchways API.

```
{
    "posts": [{
    "id": 1,
    "author": "Rylee Paul",
    "authorId": 9,
    "likes": 960,
    "popularity": 0.13,
    "reads": 50361,
    "tags": [ "tech", "health" ]
    },
    ...
  ]
}
```

# Installation Instructions

## Follow these steps to install and start the API:

1. Ensure that you have Rails version 5.0.7.2, Ruby version 2.7.0p0 and Bundler version 2.1.2.

2. After cloning the repository, run `bundle install` in the root of the repository to install dependencies.

3. Start Rails Server by running: `rails s`

## Using this API

The API has two endpoints:

<hr>

### /api/ping

Pings the API and returns a JSON object:

```
{
  "success": true
}
```

<hr>

### /api/posts

This route contains query parameters in order to specify the type of blog posts to return and how to sort them.

ex.
http://localhost:3000/api/posts?tags=science,tech&sortBy=likes&direction=desc

Query Parameters:
| Field | Type | Description | Default | Example |
|-------|------|-------------|---------|---------|
|tags | String (required)| A comma separated list of tags | N/A |science,tech |
|sortBy | String (optional)| The field to sort the posts by. The acceptable fields are: <br>- id <br>- reads <br>- likes <br>-popularity| id |popularity |
|direction | String (optional)| The direction for sorting. The acceptable fields are: <br>-desc <br>-asc| asc | asc |

<hr>

## Testing Instructions

Testing is done through the Rpsec framework.

To execute the specs run: `bundle exec rpsec`

## Caching Feature

Because making API calls to the server can be expensive, this API uses the built-in Rails caching feature to cache the responses from the Hatchways API.

## Dependencies:

- Rails 5.0.7.2
- Ruby 2.7.0p0
- Rspec-rails 3.5
- HTTParty 0.20.0
- Sqlite3 1.4.2
- Nokogiri
- Thread
