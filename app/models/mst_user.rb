class MstUser < ActiveRecord::Base
	has_one :trans_user_informations, class_name: "TransUserInformation",
	foreign_key: "user_id"
	has_one :mst_bank_details, class_name: "MstBankDetail",
	foreign_key: "user_id_fk"

	has_one :trans_role_users, class_name: "TransRoleUser",foreign_key: "user_id"

		EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	  validates :user_email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
	  validates :user_password, :confirmation => true #password_confirmation attr
	  validates_length_of :user_password, :in => 8..20, :on => :create

end
