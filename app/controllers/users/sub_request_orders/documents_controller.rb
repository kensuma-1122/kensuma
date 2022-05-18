module Users::SubRequestOrders
  class DocumentsController < Users::Base
    layout 'documents'

    def index
      sub_request_order = validate_request_order!

      @documents = sub_request_order.documents
      render 'users/documents/index'
    end

    def show
      sub_request_order = validate_request_order!
      @documents = sub_request_order.documents
      @document = @documents.find_by!(uuid: params[:uuid])

      respond_to do |format|
        format.html
        format.pdf do
          case @document.document_type
          when 'cover_document', 'table_of_contents_document', 'doc_2nd', 'doc_8th'
            return render template: 'users/documents/show',
              pdf: '書類',
              layout: 'pdf',
              encording: 'UTF-8',
              page_size: 'A4'
          when 'doc_5th'
            return render pdf: '書類',
              layout: 'pdf',
              encording: 'UTF-8',
              page_size: 'A4',
              margin: { top: 0 },
              orientation: 'Landscape'
          end
        end
      end
      render 'users/documents/show'
    end

    private

    def validate_request_order!
      request_order = current_business.request_orders.find_by!(uuid: params[:request_order_uuid])
      sub_request_order = RequestOrder.find_by!(uuid: params[:sub_request_order_uuid])
      unless sub_request_order.child_of?(request_order)
        raise 'だめ'
      end

      sub_request_order
    end
  end
end
