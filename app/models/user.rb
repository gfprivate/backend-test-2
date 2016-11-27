class User < ActiveRecord::Base
  has_many :company_numbers_assignees
  has_many :company_numbers, through: :company_numbers_assignees
  has_one :user_number
end
