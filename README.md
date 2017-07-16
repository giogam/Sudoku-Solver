# Sudoku-Solver
Ruby implementation of the Peter Norvig's sudoku solving algorithm. Actually seems to perform like the native Python implementation; On an Intel I7 2600K solves the hard puzzle below in 1' and 15". There is also a little test suite based on the one found in the original article. For a more detailed point of view you should read [This](http://norvig.com/sudoku.html)

#Code Sample 

```ruby
require_relative 'sudoku_solver'

  grid1  = '003020600900305001001806400008102900700000008006708200002609500800203009005010300'
  grid2  = '4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......'
  hard1  = '.....6....59.....82....8....45........3........6..3.54...325..6..................'

  sudoku_solver = SudokuSolver.new

  sudoku_solver.solve(hard1)
```
