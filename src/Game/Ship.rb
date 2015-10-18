module Game
  class Ship
    attr_reader :orientation, :coordinates, :size

    def initialize(size, orientation, coordinates)
      throw ArgumentError unless size.is_a?(Integer)
      throw ArgumentError unless Game::Ship::Orientation.all.include?(orientation)
      throw ArgumentError unless coordinates.is_a?(Game::Grid::Coordinates)

      @size = size
      @orientation = orientation
      @coordinates = coordinates
      @hits = Array.new(size, false)
    end

    def hit(segment)
      @hits[segment] = true
    end

    def hit?(segment)
      @hits[segment] || false
    end

    def sunk?
      !@hits.uniq.include? false
    end
  end
end