module Users
  class DocumentsController < Users::Base
    layout 'documents'
    before_action :set_documents # サイドバーに常時表示させるために必要
    before_action :set_document, except: :index # オブジェクトが1つも無い場合、indexで呼び出さないようにする
    before_action :set_cover_document, except: :index # 同上

    def index
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
        flash[:success] = '更新に成功しました'
        redirect_to users_document_url(@document)
      else
        flash[:danger] = '更新に失敗しました'
        render :edit
      end
    end

    def cover
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: '表紙',
                layout: 'application',
                encording: 'UTF-8',
                page_size: 'A4'
        end
      end
    end

    private

    def set_documents
      @documents = Document.all.order(id: :asc)
    end

    def set_document
      @document = Document.find_by(uuid: params[:uuid])
    end

    def set_cover_document
      @cover_document = @document.cover_document
    end

    def cover_document_params
      params.require(:cover_document).permit(:business_name, :submitted_on)
    end
  end
end
