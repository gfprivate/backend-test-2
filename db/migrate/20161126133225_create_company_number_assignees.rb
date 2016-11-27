class CreateCompanyNumberAssignees < ActiveRecord::Migration
  def change
    create_join_table :users, :company_numbers, table_name: :company_numbers_assignees do |t|
      t.integer :order
    end
    add_index :company_numbers_assignees, [:user_id, :company_number_id], unique: true, name: 'index_company_numbers_assignees_user_number'
    add_index :company_numbers_assignees, [:company_number_id, :order], unique: true, name: 'index_company_numbers_assignees_number_order'
  end
end
