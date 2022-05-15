module Api::Users
  class WorkersController < Api::Users::Base
    def show
      @worker = current_business.workers.find(params[:id])
    end
  end
end
