class BusinessFrom
  include ActiveModel::Model

  concerning :CompanyBuilder do
    def business
      @business ||= Business.new
    end
  end

  attr_accessor :uuid, :name, :name_kana, :branch_name, :representative_name, :email, :address, :post_code, :phone_number, :carrier_up_id,
    :business_type

  validate :validate_something

  def save
    # バリデーションに引っかかる場合は以降の処理には行かせずfalseをコントローラーに返します
    return false if invalid?

    business.assign_attributes(business_params)
    build_asscociations

    if company.save
      true
    else
      false
    end
  end

  private

  def business_params
    {
      uuid:                name,
      name:                name,
      name_kana:           name_kana,
      branch_name:         branch_name,
      representative_name: representative_name,
      email:               email,
      address:             address,
      post_code:           post_code,
      phone_number:        phone_number,
      carrier_up_id:       carrier_up_id,
      business_type:       business_type
    }
  end

  def build_asscociations
    company.employees << employees
    company.president = president
  end

  def validate_something
    # Do something
  end
end
