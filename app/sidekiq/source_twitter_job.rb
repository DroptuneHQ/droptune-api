class SourceTwitterJob
  include Sidekiq::Job

  def perform(artist_id)
    artist = Artist.find(artist_id)

    if artist.twitter.present?
      endpoint_url = "https://api.twitter.com/2/users/by/username/#{artist.twitter.value}"

      query_params = {
        "user.fields" => "id"
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

      Source.find_or_create_by(artist: artist, name: 'twitter_id', value: formatted_response['data']['id'].to_i)

      BuildTwitterJob.perform_async(artist.id)
    end
  end
end
