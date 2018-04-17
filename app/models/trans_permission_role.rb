class TransPermissionRole < ActiveRecord::Base
	belongs_to :mst_roles, class_name: "MstRole"
end
