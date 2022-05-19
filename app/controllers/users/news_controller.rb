module Users
  class NewsController < Users::Base
    after_action :unread_news_count
    before_action :set_news, except: :index # オブジェクトが1つも無い場合、indexで呼び出さないようにする

    def index
      @news_all = News.published.page(params[:page]).per(10).order(delivered_at: 'DESC')
    end

    def show
      update_read_status!
      unread_news_count
    end

    private

    def set_news
      @news = News.find_by(uuid: params[:uuid])
    end

    def update_read_status!
      if NewsUser.where(user_id: current_user.id, news_id: @news.id).blank?
        news_user = @news.news_users.build
        news_user.user = current_user
        news_user.save!
      end
    end
  end
end
