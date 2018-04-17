class MstCategory < ActiveRecord::Base
  has_many :children, class_name: "MstCategory", foreign_key: "parent_id"
  belongs_to :parent, class_name: "MstCategory"
  has_many :trans_categories,  :class_name => "TransCategory", :foreign_key => "category_id_fk"
  validates :slug, :presence => true, :uniqueness => true
end
