module Users
  class NewsController < Users::Base
    def index
      @news_all = News.all.order(delivered_at: 'DESC')
    end

    def show
      @news = News.find(params[:id])
    end
  end
end
