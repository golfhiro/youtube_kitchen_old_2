class TopsController < ApplicationController
  require 'google/apis/youtube_v3'

  def index
  #   genres = ["和食", "洋食", "中華"]
  #   ingredients =  ["豚肉", "牛肉", "鶏肉"]
  #   youtubers = ["武島たけしの極み飯", "料理研究家リュウジのバズレシピ", "Koh Kentetsu Kitchen【料理研究家コウケンテツ公式チャンネル】", "だれウマ【料理研究家】", "鳥羽周作のシズるチャンネル ", "はるあん"]

  #   genre = genres.sample
  #   ingredient = ingredients.sample
  #   youtuber = youtubers.sample

  #   # キャッシュがあればそれを返し、なければ新しく取得してキャッシュに保存
  #   @videos = Rails.cache.fetch('search_result_list', expires_in: 1.hour) do
  #     youtube = Google::Apis::YoutubeV3::YouTubeService.new
  #     youtube.key = Rails.application.credentials.youtube_api[:youtube_api_key]

  #     youtube.list_searches(
  #       "id,snippet",
  #       q: "#{genre} #{ingredient} #{youtuber} レシピ",
  #       type: "video",
  #       video_definition: "high",
  #       video_duration: "long",
  #       order: "relevance",
  #       max_results: 1,
  #     )
  #   end
  end

end
