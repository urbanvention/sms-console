# phone.rb ;; 2010 (cc) Jan Riethmayer
# This work is licensend under a Creative Commons Attribution 3.0 license.

class Phone
  attr_accessor :label, :number
  def initialize data
    @label  = data.label.get
    @number = data.value.get
  end

  def mobile?
    @label == "mobile"
  end
end
