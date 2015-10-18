module Game
  class Grid
    class Coordinates
      attr_reader :x, :y

      def initialize(x, y)
        throw ArgumentError unless x.is_a?(Integer) && y.is_a?(Integer)
        throw RangeError if x < 0 || y < y
        @x, @y = x, y
      end

      def ==(other)
        @x == other.x && @y == other.y
      end
    end
  end
end