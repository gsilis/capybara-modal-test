class PrettyListItem < ActiveRecord::Base
  validates_presence_of     :title
  validates_numericality_of :sort_order, greater_than: 0
end
