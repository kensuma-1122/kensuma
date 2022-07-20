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
          when 'cover_document', 'table_of_contents_document', 'doc_3rd', 'doc_4th', 'doc_5th', 'doc_6th',
                'doc_7th', 'doc_9th', 'doc_10th', 'doc_11th', 'doc_12th',
                'doc_13th', 'doc_14th', 'doc_15th', 'doc_16th', 'doc_17th', 'doc_18th',
                'doc_19th', 'doc_20th', 'doc_21st', 'doc_22nd', 'doc_23rd', 'doc_24th'
            return render template: 'users/documents/show',
              pdf: '書類',
              layout: 'pdf',
              encording: 'UTF-8',
              page_size: 'A4'
          when 'doc_8th'
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
      unless sub_request_order.child_of?(request_order) || sub_request_order.descendant_of?(request_order)
        raise 'だめ'
      end

      sub_request_order
    end
  end
end
