module Gerund
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def model_name
      superclass.model_name
    end

    def sti_name
      superclass.sti_name
    end

    def finder_needs_type_condition?
      superclass.finder_needs_type_condition?
    end

    def find_sti_class(type_name)
      sti_class = super
      if self <= sti_class
        self
      else
        sti_class
      end
    end
  end
end
