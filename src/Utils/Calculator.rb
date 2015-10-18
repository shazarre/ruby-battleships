module Utils
  class Calculator

    # Calculates segment index for given ship based on passed coordinates
    def self.ship_segment_from_coordinates(ship, coordinates)
      if ship.orientation == Game::Ship::Orientation::HORIZONTAL
        coordinates.x - ship.coordinates.x
      else
        coordinates.y - ship.coordinates.y
      end
    end

    # Returns array of all ship segments' coordinates
    def self.ship_coordinates(ship)
      coordinates = []

      if ship.orientation == Game::Ship::Orientation::HORIZONTAL
        for x in ship.coordinates.x..(ship.coordinates.x + ship.size - 1)
          coordinates << Game::Grid::Coordinates.new(x, ship.coordinates.y)
        end
      else
        for y in ship.coordinates.y..(ship.coordinates.y + ship.size - 1)
          coordinates << Game::Grid::Coordinates.new(ship.coordinates.x, y)
        end
      end

      coordinates
    end
  end
end