module Game
  module Exceptions
    # Exception raised when given coordinates are already taken on grid by other ship.
    class CoordinatesAlreadyTaken < StandardError

    end
  end
end