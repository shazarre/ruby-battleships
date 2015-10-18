module Game
  class Grid
    attr_reader :size, :ships

    def initialize(size)
      raise ArgumentError unless size.is_a? Integer
      @size = size
      @ships = []
    end

    def ship?(coordinates)
      ship_at(coordinates) { |ship|
        return true
      }

      false
    end

    def add_ship(ship)
      Utils::Calculator.ship_coordinates(ship).each do |coordinate|
        raise Game::Exceptions::CoordinatesOutOfGrid unless includes?(coordinate)
        raise Game::Exceptions::CoordinatesAlreadyTaken if ship?(coordinate)
      end

      @ships << ship
    end

    def ship_at(coordinates)
      for ship in @ships
        if ship.orientation == Game::Ship::Orientation::HORIZONTAL
          if coordinates.y == ship.coordinates.y
            yield ship if (ship.coordinates.x..(ship.coordinates.x + ship.size - 1)).include? coordinates.x
          end
        else
          if coordinates.x == ship.coordinates.x
            yield ship if (ship.coordinates.y..(ship.coordinates.y + ship.size - 1)).include? coordinates.y
          end
        end
      end
    end

    def includes?(coordinates)
      raise ArgumentError unless coordinates.is_a? Coordinates

      coordinates.x < self.size && coordinates.y < self.size
    end
  end
end