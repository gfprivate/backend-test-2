class CompanyNumbersAssignee < ActiveRecord::Base
  belongs_to :company_number
  belongs_to :user

  def self.getNextAssignee(company_number_id, order)
    order_field = self.arel_table[:order]
    self
      .where(company_number: company_number_id)
      .where(order_field.gt(order))
      .order(order_field.asc())
      .first
  end
end
