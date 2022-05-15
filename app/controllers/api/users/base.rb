# frozen_string_literal: true

module Api::Users
  class Base < ApplicationController
    before_action :authenticate_user!
  end
end
