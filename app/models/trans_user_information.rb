class TransUserInformation < ActiveRecord::Base
	belongs_to :mst_users, class_name: "MstUser"
	validates :user_name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
end
