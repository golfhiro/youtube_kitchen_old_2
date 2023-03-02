class TopsController < ApplicationController
  require 'google/apis/youtube_v3'

  def index

    #Youtube動画の取得
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = Rails.application.credentials.youtube_api[:youtube_api_key]

    @videos = Rails.cache.fetch('search_result_list', expires_in: 12.hours) do
      youtube.list_searches("id,snippet", q: "GReeeeN", type: "video", max_results: 1)
    end || []

  end
end
