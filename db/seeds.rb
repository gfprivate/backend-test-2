# Users

jane = User.create(name: 'Jane')
peter = User.create(name: 'Peter')
luke = User.create(name: 'Luke')

# UserNumbers

jane_number = UserNumber.create(user_id: jane.id, sip_endpoint: 'jane161126100142')
peter_number = UserNumber.create(user_id: peter.id, sip_endpoint: 'peter161126100154')
luke_number = UserNumber.create(user_id: luke.id, sip_endpoint: 'luke161126100211')

# CompanyNumbers

main_number = CompanyNumber.create(sip_endpoint: 'companymain161126100404')
sales_number = CompanyNumber.create(sip_endpoint: 'companysales161126101000')
support_number = CompanyNumber.create(sip_endpoint: 'companysupport161126101017')

# CompanyNumbersAssignees

CompanyNumbersAssignee.create(user_id: jane.id, company_number_id: main_number.id, order: 1)
CompanyNumbersAssignee.create(user_id: luke.id, company_number_id: main_number.id, order: 2)
CompanyNumbersAssignee.create(user_id: peter.id, company_number_id: main_number.id, order: 3)

CompanyNumbersAssignee.create(user_id: luke.id, company_number_id: sales_number.id, order: 1)
CompanyNumbersAssignee.create(user_id: jane.id, company_number_id: sales_number.id, order: 2)
CompanyNumbersAssignee.create(user_id: peter.id, company_number_id: sales_number.id, order: 3)

CompanyNumbersAssignee.create(user_id: peter.id, company_number_id: support_number.id, order: 1)
CompanyNumbersAssignee.create(user_id: jane.id, company_number_id: support_number.id, order: 2)
CompanyNumbersAssignee.create(user_id: luke.id, company_number_id: support_number.id, order: 3)
