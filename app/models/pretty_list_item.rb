class PrettyListItem < ActiveRecord::Base
  validates_presence_of     :name
  validates_numericality_of :sort_order, greater_than: 0
  validates_uniqueness_of   :sort_order

  default_scope             lambda{ order('sort_order asc') }

  after_initialize          :initialize_with_defaults, if: :new_record?

  private
    def initialize_with_defaults
      self.sort_order = (self.class.maximum(:sort_order) || 0) + 1
    end
end
