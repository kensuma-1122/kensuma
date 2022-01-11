# frozen_string_literal: true

module Users
  class BusinessesController < Users::Base
    def new
      @business = Business.new
    end

    def create
      redirect_to new_users_business_path # 仮redirect
    end

    def edit
    end

    def update
    end

    def show
    end
  end
end
