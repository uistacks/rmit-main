# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#setting table
MstSetting.create(key: 'site-title', name: "Site Title",value: "MyAdmin",active:"1",lang_id: "17")
MstSetting.create(key: 'site-email', name: "Site Email",value: "ramesh@panaceatek.com",active:"1",lang_id: "17")
MstSetting.create(key: 'contact-email', name: "Contact Email",value: "grace@panaceatek.com",active:"1",lang_id: "17")
MstSetting.create(key: 'date-format', name: "Date Format",value: "%d.%m.%Y %T",active:"1",lang_id: "17")
MstSetting.create(key: 'address', name: "Address",value: "kalyani nagar",active:"1",lang_id: "17")
MstSetting.create(key: 'zip-code', name: "Zip Code",value: "411015",active:"1",lang_id: "17")
MstSetting.create(key: 'contact-number', name: "Contact Number",value: "9762137636",active:"1",lang_id: "17")

MstUser.create(user_email: 'ramesh@panaceatek.com',role: '1', user_password: Base64.encode64("Pass@123"))
TransUserInformation.create(user_id: '1', first_name: "Ramesh", last_name: "Kumar", user_name: "admin", user_mobile: "1234567890", user_type: "1", user_status: "1", activation_code: "1")

#role insertion
MstRole.create(name: 'SuperAdmin', description: "Site Owner, who has all permissions.")
MstRole.create(name: 'RegisteredUser', description: "A frontend user")
MstRole.create(name: 'SubAdmin', description: "A backend user, who can work as per assign task by SuperAdmin")

#assign a role to SuperAdmin
TransRoleUser.create(user_id: '1', role_id: "1")

#permission insertion
MstPermission.create(name: 'Manage Roles')
MstPermission.create(name: 'Manage Users')
MstPermission.create(name: 'Manage CMS')
MstPermission.create(name: 'Manage Emailtemplate')
