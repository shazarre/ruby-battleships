module Game
  class Grid
    class Coordinates
      attr_reader :x, :y

      def initialize(x, y)
        raise ArgumentError unless x.is_a?(Integer) && y.is_a?(Integer)
        raise RangeError if x < 0 || y < y
        @x, @y = x, y
      end

      def ==(other)
        @x == other.x && @y == other.y
      end
    end
  end
end