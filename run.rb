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

grid = Game::Grid.new(10)
engine = Game::Engine.new(grid)

# TODO Randomize ship generation
grid.add_ship(Game::Ship.new(
 5,
 Game::Ship::Orientation::HORIZONTAL,
 Game::Grid::Coordinates.new(0, 0)
))

grid.add_ship(Game::Ship.new(
  4,
  Game::Ship::Orientation::VERTICAL,
  Game::Grid::Coordinates.new(0, 2)
))


grid.add_ship(Game::Ship.new(
  4,
  Game::Ship::Orientation::HORIZONTAL,
  Game::Grid::Coordinates.new(6, 6)
))

UserInterface::Console.new(
  engine,
  UserInterface::Renderer.new(
    grid
  )
).run