module Users
  class DocumentsController < Users::Base
    include DocumentsConcern

    layout 'documents'
    before_action :set_documents # サイドバーに常時表示させるために必要
    before_action :set_document, except: :index # オブジェクトが1つも無い場合、indexで呼び出さないようにする
    before_action :set_cover_documents, only: :index # サイドバー表示 表紙一覧

    def index; end

    def show
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: '表紙',
            layout: 'pdf',
            encording: 'UTF-8',
            page_size: 'A4'
        end
      end
    end

    def edit; end

    def update
      if select_params
        flash[:success] = '更新に成功しました'
        redirect_to users_request_order_document_url
      else
        flash[:danger] = '更新に失敗しました'
        render :edit
      end
    end

    def select_params
      if @document.document_type == 'cover_document'
        @document.update(document_params)
      elsif @document.document_type == "doc_2nd"
        @document.update(second_document_params)
      end
    end

    # def cover
    #   respond_to do |format|
    #     format.html
    #     format.pdf do
    #       render pdf: '表紙',
    #         layout: 'pdf',
    #         encording: 'UTF-8',
    #         page_size: 'A4'
    #     end
    #   end
    # end

    private

    def set_document
      @document = current_business.request_orders.find_by(uuid: params[:request_order_uuid]).documents.find_by(uuid: params[:uuid])
    end

    def set_cover_documents
      @cover_documents = current_business.documents.document_type_cover
    end

    # def set_cover_document
    #   @cover_document = current_business.documents.document_type_cover.find_by(uuid: params[:uuid])
    # end

    def document_params
      params.require(:document).permit.merge(
        content: {
          business_name: params[:document][:content][0],
          submitted_on:  params[:document][:content][1]
        })
    end

    def second_document_params
      params.require(:document).permit.merge(
        content: {
          submitted_on:           params[:document][:content][0],
          prime_contractor_name:  params[:document][:content][1],
          site_name:              params[:document][:content][2],
          business_name:          params[:document][:content][3],
          orderer_name:           params[:document][:content][4],
          construction_name:      params[:document][:content][5],
          supervisor_name:        params[:document][:content][6],
          apply:                  params[:document][:content][7],
          submission_destination: params[:document][:content][8]
        }
      )
    end
  end
end
