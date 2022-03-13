module Users
  class DocumentsController < Users::Base
    layout 'documents'

    before_action :set_documents
    before_action :set_document, only: %i[show edit update]

    def index
      # テスト用デフォルト値============================
      # indexに遷移時、10件までdocument,cover_documentを作成
      if Document.count < 10
        10.times do |n|
          document = Document.create!(created_on: Date.yesterday,  submitted_on: Date.current)
          document.build_cover_document(business_name: "事業所表紙#{n + 1}", submitted_on: Date.current)
          document.save!
        end
      end
      # ==============================================
    end

    def show; end

    def edit; end

    def update
      if @document.update(document_params)
        flash[:success] = '更新しました'
        redirect_to users_document_url
      else
        render :edit
      end
    end

    private

    def set_documents
      @documents = Document.all # テスト用 仮
    end

    def set_document
      @document = Document.find_by(uuid: params[:uuid]) # テスト用 仮
    end

    def document_params
      params.require(:document).permit(:created_on, :submitted_on)
    end
  end
end
