# frozen_string_literal: true

module Users
  class DashBoardsController < Users::Base
    before_action :business_nil_access

    def index; end
  end
end
