# class TopsController < ApplicationController
#   require 'google/apis/youtube_v3'

#   def index
#     genres = ["和食", "洋食", "中華"]
#     ingredients =  ["豚肉", "牛肉", "鶏肉", "鮭", "豆腐", "さば"]

#     genre = genres.sample
#     ingredient = ingredients.sample
#     # youtuber = youtubers.sample

#     # キャッシュがあればそれを返し、なければ新しく取得してキャッシュに保存
#     @videos = Rails.cache.fetch('search_result_list', expires_in: 12.hour) do
#       youtube = Google::Apis::YoutubeV3::YouTubeService.new
#       youtube.key = Rails.application.credentials.youtube_api[:youtube_api_key]

#       youtube.list_searches(
#         "id,snippet",
#         # q: "#{genre} #{ingredient} #{youtuber} レシピ",
#         q: "#{ingredient}  レシピ #{genre}",
#         type: "video",
#         order: "relevance",
#         max_results: 7,
#       )
#     end

#     # 曜日ごとに動画をグループ化する
#     @menu = {}
#     days = %w[ Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
#     @videos.items.each_with_index do |video, index|
#       day_index = index % 7
#       day = days[day_index]
#       @menu[day] ||= []
#       @menu[day] << video
#       debugger
#     end
#   end
# end

###　材料が違う7つの動画を曜日ごとに表示。
class TopsController < ApplicationController
  require 'google/apis/youtube_v3'

  def index
    #材料を用意
    ingredients = ["豚肉", "鶏肉", "鯖,", "牛肉", "鮭", "豆腐", "キャベツ", "挽肉", "海老", "白菜", "まぐろ"]
    select_ingredients = ingredients.sample(7)

    @related_videos = []
    @menu = {}

    #キャッシュにあればそれを返し、なければ更新
    @videos = Rails.cache.fetch('search_result_list', expires_in: 12.hour) do
      youtube = Google::Apis::YoutubeV3::YouTubeService.new
      youtube.key = Rails.application.credentials.youtube_api[:youtube_api_key]

      select_ingredients.each do |ingredient|
        responce = youtube.list_searches(
          'snippet',
          q: ingredient + "レシピ",
          type: 'video',
          order: "relevance",
          max_results: 1
        )

        responce.items.each do |item|
          @related_videos << {
            # title: item.snippet.title,
            video_id: item.id.video_id,
            # thumbnail: item.snippet.thumbnails.high.url
          }
        end
      end

        # 曜日ごとに動画をグループ化する
        days = %w[ Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
        @related_videos.each_with_index do |video, index|
          day_index = index % 7
          day = days[day_index]
          @menu[day] ||= []
          @menu[day] << video
        end

      return @menu
    end
  end
end
