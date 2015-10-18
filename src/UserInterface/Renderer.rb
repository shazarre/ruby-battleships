module UserInterface
  # Grid renderer.
  class Renderer
    SQUARE_HIT = " X "
    SQUARE_UNKNOWN = " . "
    SQUARE_MISS = " - "
    SQUARE_EMPTY = "   "

    def initialize(grid)
      @grid = grid
      @missed = []
    end

    def add_missed(coordinates)
      @missed << coordinates
    end

    # Renders current grid state.
    def render(reveal = false)
      alphabet = ("A".."Z").to_a
      print SQUARE_EMPTY
      for x in 1..@grid.size
        print " #{x} "
      end
      puts
      for y in 0..@grid.size - 1
        print " #{alphabet[y]} "
        for x in 0..@grid.size - 1
          coordinates = Game::Grid::Coordinates.new(x, y)
          if reveal
            if @grid.ship?(coordinates)
              print SQUARE_HIT
            else
              print SQUARE_EMPTY
            end
          else
            if @grid.ship?(coordinates)
              @grid.ship_at(coordinates) { |ship|
                segment = Utils::Calculator.ship_segment_from_coordinates(ship, coordinates)

                if ship.hit?(segment)
                  print SQUARE_HIT
                else
                  print SQUARE_UNKNOWN
                end
              }
            else
              if @missed.include? coordinates
                print SQUARE_MISS
              else
                print SQUARE_UNKNOWN
              end
            end
          end
        end

        puts
      end
    end
  end
end