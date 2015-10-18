module UserInterface
  class Console
    MESSAGE_DUPLICATE = "You've already made that hit."
    MESSAGE_HIT = "You hit enemy vessel."
    MESSAGE_MISS = "You missed."
    MESSAGE_SUNK = "You sank enemy vessel."
    MESSAGE_ENTER_COORDINATES = "Enter coordinates (row, col), e.g. A5 = "
    MESSAGE_OUT_OF_BOUNDS = "Requested coordinates are out of bounds. Please try again."

    def initialize(engine, renderer)
      throw ArgumentError unless engine.is_a? Game::Engine
      throw ArgumentError unless renderer.is_a? UserInterface::Renderer

      @reveal = false
      @renderer = renderer
      @engine = engine
    end

    def run
      loop do
        puts
        @renderer.render(@reveal)
        puts
        if @engine.over?
          puts "Well done! You completed the game in #{@engine.counter} shots."
          break
        end
        reset
        print MESSAGE_ENTER_COORDINATES
        command = gets.chomp
        case command
          when "exit"
            break
          when "show"
            @reveal = true
          else
            if /^[a-z][0-9][0-9]?$/i.match(command)
              command.upcase!
              coordinates = Game::Grid::Coordinates.new(
                ("#{command[1]}#{command[2]}").to_i - 1,
                command[0].ord - 65
              )

              puts

              case @engine.hit(coordinates)
                when Game::Engine::RESPONSE_OUT_OF_BOUNDS
                  puts MESSAGE_OUT_OF_BOUNDS
                when Game::Engine::RESPONSE_DUPLICATE
                  puts MESSAGE_DUPLICATE
                when Game::Engine::RESPONSE_HIT
                  puts MESSAGE_HIT
                when Game::Engine::RESPONSE_MISS
                  @renderer.add_missed(coordinates)
                  puts MESSAGE_MISS
                when Game::Engine::RESPONSE_SUNK
                  puts MESSAGE_SUNK
              end
            end
        end
      end
    end

    private
    def reset
      @reveal = false
    end
  end
end