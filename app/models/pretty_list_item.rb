class PrettyListItem < ActiveRecord::Base
  validates_presence_of     :name
  validates_numericality_of :sort_order, greater_than: 0
  validates_uniqueness_of   :sort_order

  default_scope             lambda{ order('sort_order asc') }
end
