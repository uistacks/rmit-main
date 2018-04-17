class TransRoleUser < ActiveRecord::Base
  belongs_to :mst_roels, class_name: "MstRole"
  belongs_to :mst_users, class_name: "MstUser"
end
