class MstRole < ActiveRecord::Base
	has_many :trans_permission_roles, class_name: "TransPermissionRole",
                          foreign_key: "role_id"

	:name                 # the role name
  has_many :mst_users, class_name: "MstUser"
end
