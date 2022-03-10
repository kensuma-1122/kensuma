module Users
  class DocumentsController < Users::Base
    before_action :set_document, expect: [:index]
    before_action :set_documents

    layout 'users_document'

    def index; end

    def show; end

    def edit; end

    def update; end

    private

    def set_document
      @document = Document.find(params[:id])
    end

    def set_documents
      @documents = Document.all
    end
  end
end
