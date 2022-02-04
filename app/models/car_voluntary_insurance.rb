class CarVoluntaryInsurance < ApplicationRecord
  belongs_to :car
  belongs_to :car_insurance_company

  validates :personal_insurance, presence :true
  validates :objective_insurance, presence :true

  enum personal_insurance: {
    無制限: 0,
    "1000": 1, "2000": 2, "3000": 3, "4000": 4, "5000": 5,
    "6000": 6, "7000": 7, "8000": 8, "9000": 9, "10000": 10,
    "11000": 11, "12000": 12, "13000": 13, "14000": 14, "15000": 15,
    "16000": 16, "17000": 17, "18000": 18, "19000": 19, "20000": 20,
  }

  enum objective_insurance: {
    無制限: 0,
    "1000": 1, "2000": 2, "3000": 3, "4000": 4, "5000": 5,
    "6000": 6, "7000": 7, "8000": 8, "9000": 9, "10000": 10,
    "11000": 11, "12000": 12, "13000": 13, "14000": 14, "15000": 15,
    "16000": 16, "17000": 17, "18000": 18, "19000": 19, "20000": 20,
  }
end
