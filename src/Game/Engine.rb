module Game
  # Handles game logic.
  class Engine
    attr_reader :grid, :counter

    RESPONSE_MISS = 'miss'
    RESPONSE_HIT = 'hit'
    RESPONSE_SUNK = 'sunk'
    RESPONSE_DUPLICATE = 'duplicate'
    RESPONSE_OUT_OF_BOUNDS = 'out_of_bounds'

    def initialize(grid)
      raise ArgumentError unless grid.is_a? Game::Grid

      @grid = grid
      @counter = 0
      @hits = []
    end

    # Returns if game is over.
    def over?
      !@grid.ships.map { |ship|
        ship.sunk?
      }.uniq.include?(false)
    end

    # On given coordinates performs action. Returns class constants:
    # - RESPONSE_OUT_OF_BOUNDS: when given coordinates don't fit into grid
    # - RESPONSE_DUPLICATE: when given shoot has already been made
    # - RESPONSE_SUNK: when enemy ship has just been sunk
    # - RESPONSE_HIT: when enemy ship has just been hit (but not sunk)
    # - RESPONSE_MISS: when given shoot missed any ships
    def hit(coordinates)
      return RESPONSE_OUT_OF_BOUNDS unless @grid.includes?(coordinates)
      return RESPONSE_DUPLICATE if hit?(coordinates)
      @hits << coordinates

      @grid.ship_at(coordinates) { |ship|
        segment = Utils::Calculator.ship_segment_from_coordinates(ship, coordinates)
        unless ship.hit?(segment)
          ship.hit(segment)

          if ship.sunk?
            increment_counter
            return RESPONSE_SUNK
          else
            increment_counter
            return RESPONSE_HIT
          end
        end
      }

      increment_counter
      RESPONSE_MISS
    end

    private
    def hit?(coordinates)
      @hits.include? coordinates
    end

    def increment_counter
      @counter += 1
    end
  end
end