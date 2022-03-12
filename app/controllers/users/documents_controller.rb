module Users
  class DocumentsController < Users::Base
    layout 'users_document'

    before_action :set_document, except: [:index]
    before_action :set_documents
    before_action :set_cover_document, except: [:index]

    def index
      # とりあえず仮でdocumentと紐づくcover_document作成。(特に意味はないですが３つのみ作成できる。)
      if @documents.count < 3
        3.times do
          document = Document.create!
          document.build_cover_document.save!
        end
      end
    end

    def show; end

    def edit; end

    def update
      if @cover_document.update(cover_document_params)
        flash[:success] = '更新しました'
        redirect_to users_document_url(@document)
      else
        render :edit
      end
    end

    private

    def set_document
      @document = Document.find_by(uuid: params[:uuid])
    end

    def set_documents
      @documents = Document.all
    end

    def set_cover_document
      @cover_document = @document.cover_document
    end

    def cover_document_params
      params.require(:cover_document).permit(:business_name, :submitted_on)
    end
  end
end
