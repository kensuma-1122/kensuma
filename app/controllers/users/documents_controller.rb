module Users
  class DocumentsController < Users::Base
    layout 'document'

    def index
      
    end

    def show
      @document = Document.new(created_on: Date.current, submitted_on: Date.current)
    end

    def edit
      @document = Document.new(created_on: Date.current, submitted_on: Date.current)
    end

    def update; end
  end
end
