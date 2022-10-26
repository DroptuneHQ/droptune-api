class BuildTwitterJob
  include Sidekiq::Job

  def perform(artist_id)
    artist = Artist.find(artist_id)

    endpoint_url = "https://api.twitter.com/2/users/#{artist.twitter_id.value}/tweets?exclude=retweets,replies"

    query_params = {
      "max_results" => 50,
      # "start_time" => "2020-07-01T00:00:00Z",
      # "end_time" => "2020-07-02T18:00:00Z",
      "expansions" => "attachments.poll_ids,attachments.media_keys,author_id",
      "tweet.fields" => "attachments,author_id,conversation_id,created_at,entities,id,lang",
      "user.fields" => "description"
    }

    options = {
      method: 'get',
      headers: {
        "User-Agent" => "Droptune",
        "Authorization" => "Bearer #{ENV['twitter_bearer']}"
      },
      params: query_params
    }

    request = Typhoeus::Request.new(endpoint_url, options)
    response = request.run

    formatted_response = JSON.parse(response.body)

    formatted_response['data'].each do |tweet|
      new_tweet = Tweet.create_with(body: tweet['text'], created_at: tweet['created_at']).find_or_create_by(twitter_id: tweet['id'], artist: artist)
    end
  end
end
