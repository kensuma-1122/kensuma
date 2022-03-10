module Users
  class DocumentsController < Users::Base
    layout 'users_document'
    
    def index
      @documents = Document.all
    end

    def show; end

    def edit; end

    def update; end
  end
end
