module Game
  class Ship
    # Stores possible ship orientations.
    module Orientation
      HORIZONTAL = 'horizontal'
      VERTICAL = 'vertical'

      # Returns all possible ship orientations.
      def self.all
        [HORIZONTAL, VERTICAL]
      end
    end
  end
end