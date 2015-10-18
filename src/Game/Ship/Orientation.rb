module Game
  class Ship
    module Orientation
      HORIZONTAL = 'horizontal'
      VERTICAL = 'vertical'

      def self.all
        [HORIZONTAL, VERTICAL]
      end
    end
  end
end