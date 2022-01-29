module Users
  class Users::CarsController < Users::Base
    def index; end

    def new
      @car = @business.cars.new
    end

    def create; end

    def edit; end

    def update; end

    def show; end

    def destroy; end
  end
end
