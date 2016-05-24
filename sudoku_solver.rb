
class SudokuSolver
  require_relative 'app_helper'

  def initialize
    @digits   = '123456789'
    @rows     = 'ABCDEFGHI'
    @cols     =  @digits
    @squares  =  AppHelper.cross_prod(@rows, @cols)
    @ulist    =  AppHelper.unitlist(@rows, @cols)
    @units    =  AppHelper.units(@ulist, @squares)
    @peers    =  AppHelper.peers(@units, @squares)
  end

  def solve(grid)
    values = Hash.new
    @squares.each { |s| values[s] = @digits }
    AppHelper.grid_values(grid, @squares).each { |key, val| assign(values, key, val) if @digits.include? val }
    pretty_print(values)
  end

################ Constraint Propagation ################

  def assign(values, s, d)
    values[s].sub(d,'').chars { |d2| eliminate(values, s, d2) }
    values
  end


  def eliminate(values, s, d)
    return values unless values[s].include? d
    values[s] = values[s].sub(d,'')
    if values[s].length == 0
      return false
      # (1) If a square s is reduced to one value d2, then eliminate d2 from the peers.
    elsif values[s].length == 1
      d2 = values[s]
      @peers[s].each { |s2| eliminate(values, s2, d2) }
      #return false
    end
    # (2) If a unit u is reduced to only one place for a value d, then put it there.
    dplaces = [ ]
    @units[s].each { |u|
      u.each { |el| dplaces << el if values[el].include? d }
      if dplaces.length == 0
        return false
      elsif dplaces.length == 1
        # d can only be in one place in unit; assign it there
        assign(values, dplaces[0], d)
      end
    }
    values
  end

################ Display as 2-D grid ################

  def pretty_print(values)
    len = []
    @squares.each { |s| len << values[s].length }
    width = 1 + len.max
    grid_line = ['-'*(width*3), '-'*(width*3), '-'*(width*3)].map { |k| "#{k}" }.join("+")
    row = ''

    @rows.chars { |r|
      row.clear
      @cols.chars { |c|
        row += values[r+c].center(width)
        ('36'.include? c) ? row += '|' : row += ''
      }
      p row
      p grid_line if 'CF'.include? r
    }
  end


end

grid1  = '003020600900305001001806400008102900700000008006708200002609500800203009005010300'

sudoku_solver = SudokuSolver.new
sudoku_solver.solve(grid1)