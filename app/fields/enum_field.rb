require "administrate/field/base"

class EnumField < Administrate::Field::Base
  def to_s
    data.humanize unless data.nil?
  end
end
