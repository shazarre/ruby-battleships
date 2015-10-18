require './src/Game/Engine'
require './src/Game/Exceptions/CoordinatesAlreadyTaken'
require './src/Game/Exceptions/CoordinatesOutOfGrid'
require './src/Game/Grid'
require './src/Game/Grid/Coordinates'
require './src/Game/Ship'
require './src/Game/Ship/Orientation'
require './src/UserInterface/Renderer'
require './src/UserInterface/Console'
require './src/Utils/Calculator'

grid_size = 10
grid = Game::Grid.new(grid_size)
engine = Game::Engine.new(grid)

sizes = [5, 4, 4]

while sizes.length > 0
  begin
    grid.add_ship(
      Game::Ship.new(
        sizes.first,
        Game::Ship::Orientation.all[rand(0..1)],
        Game::Grid::Coordinates.new(
            rand(0..(grid_size - 1)),
            rand(0..(grid_size - 1))
        )
      )
    )
    sizes.shift
  rescue Game::Exceptions::CoordinatesAlreadyTaken, Game::Exceptions::CoordinatesOutOfGrid
    # just continue
  end
end

UserInterface::Console.new(
  engine,
  UserInterface::Renderer.new(
    grid
  )
).run