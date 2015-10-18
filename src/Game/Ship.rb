module Game
  # Represents game ship.
  class Ship
    attr_reader :orientation, :coordinates, :size

    def initialize(size, orientation, coordinates)
      raise ArgumentError unless size.is_a?(Integer)
      raise ArgumentError unless Game::Ship::Orientation.all.include?(orientation)
      raise ArgumentError unless coordinates.is_a?(Game::Grid::Coordinates)

      @size = size
      @orientation = orientation
      @coordinates = coordinates
      @hits = Array.new(size, false)
    end

    # Marks given segment as hit.
    def hit(segment)
      @hits[segment] = true
    end

    # Checks if given segment has been hit.
    def hit?(segment)
      @hits[segment] || false
    end

    # Checks if ship has been sunk.
    def sunk?
      !@hits.uniq.include? false
    end
  end
end