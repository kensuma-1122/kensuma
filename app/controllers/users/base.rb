# frozen_string_literal: true

module Users
  class Base < ApplicationController
    before_action :authenticate_user!
    before_action :business_nil_access
    layout 'users'
  end
end
