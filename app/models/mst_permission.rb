class MstPermission < ActiveRecord::Base
  has_many :trans_permission_roles, class_name: "TransPermissionRole",
                          foreign_key: "role_id"
end
