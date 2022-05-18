class BusinessOccupation < ApplicationRecord
  belongs_to :business
  belongs_to :occupation
end
