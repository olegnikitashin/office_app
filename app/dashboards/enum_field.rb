require 'administrate/field/base'

module Administrate
  module Field
    class Enum < Administrate::Field::Base
      def to_s
        data.humanize unless data.nil?
      end
    end
  end
end