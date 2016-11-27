class CompanyNumber < ActiveRecord::Base
  has_many :company_numbers_assignees
  has_many :users, through: :company_numbers_assignees

  def self.getNextAssigneeFromEndpoint(endpoint, order)
    company_number = self.where(sip_endpoint: endpoint).first;
    CompanyNumbersAssignee.getNextAssignee(company_number.id, order) unless company_number.nil?
  end
end
