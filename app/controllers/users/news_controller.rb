module Users
  class NewsController < Users::Base
    def index
      @news_all = News.all.order(delivered_at: 'DESC')
    end

    def show
      @news = News.find(params[:id])
      update_read_status!
    end

    private

    def update_read_status!
      if NewsUser.where(user_id: current_user.id, news_id: @news.id).blank?
        news_user = @news.news_users.build
        news_user.user = current_user
        news_user.save!
      end
    end
  end
end
