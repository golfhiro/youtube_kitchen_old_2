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


class TopsController < ApplicationController
  require 'google/apis/youtube_v3'

  def index
    # キャッシュに保存された結果があればそれを返す
    @menu = Rails.cache.fetch('menu', expires_in: 12.hours) do
      # キャッシュに保存された結果がない場合、新しく検索を行う
      # 材料のキーワードを用意
      ingredients = ["豚肉", "鶏肉", "鯖,", "牛肉", "鮭", "豆腐", "キャベツ", "挽肉", "海老", "白菜", "まぐろ"]
      # ジャンルのキーワードを用意
      genres = ["和食", "洋食", "中華"]

      # 1週間分の献立を用意
      menu = {}
      %w[ Monday Tuesday Wednesday Thursday Friday Saturday Sunday].each do |day|
        # 材料とジャンルをランダムに1つずつ選択
        ingredient = ingredients.sample
        genre = genres.sample

        # YouTube APIを使用して動画を検索
        youtube = Google::Apis::YoutubeV3::YouTubeService.new
        youtube.key = Rails.application.credentials.youtube_api[:youtube_api_key]
        response = youtube.list_searches(
          'snippet',
          q: ingredient + "レシピ" + genre,
          type: 'video',
          order: "relevance",
          max_results: 1
        )

        # 検索結果を1週間分の献立に追加
        menu[day] = [{ video_id: response.items.first.id.video_id }]
      end

      # 検索結果をキャッシュに保存する
      menu
    end
  end
end
