



#モデルからorderメソッドで動画を取得するコード
  # def create
  #   genre = Genre.order("RANDOM()").first
  #   ingredient = Ingredient.order("RANDOM()").first
  #   dish = Dish.order("RANDOM()").first

  #   youtube = Google::Apis::YoutubeV3::YouTubeService.new
  #   youtube.key = Rails.application.credentials.youtube_api_key

  #   results = youtube.list_searches(
  #     "id,snippet",
  #     q: "#{genre.name} #{ingredient.name} #{dish.name}",
  #     type: "video",
  #     video_definition: "high",
  #     video_duration: "long",
  #     max_results: 1
  #   )

  #   video = results.items.first

  #   if video.present?
  #     # データベースに献立を保存する処理
  #   else
  #     flash[:alert] = "No videos found."
  #     redirect_to root_path
  #   end
  # end
