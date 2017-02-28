# MIT License
#
# Copyright (c) 2017 Giorgio Gambino
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

module AppHelper

  def self.cross_prod(a, b)
    a.chars.product(b.chars).map(&:join)
  end

  def self.group(a)
    a.scan(/[a-zA-Z0-9]{3}/)
  end

  def self.unitlist(rows, cols)
    cols.chars.map {|col| cross_prod(rows,col)} +
    rows.chars.map {|row| cross_prod(row,cols)} +
    group(rows).product(group(cols)).map {|el| cross_prod(el[0],el[1])}
  end

  #FIXME more efficient way
  def self.units(unitlist, squares)
    res = Hash.new{|hsh,key| hsh[key] = [] }
    squares.each { |s| unitlist.each { |u| res[s].push u if u.include? s } }
    res
  end

  #FIXME more efficient way
  def self.peers(units, squares)
    res = Hash.new
    squares.each { |s| res[s] = units[s].flatten.uniq.delete_if { |x| x == s } }
    res
  end

  def self.grid_values(grid, squares)
    squares.zip(grid.split('')).to_h
  end

  def self.display(values,squares,rows,cols)
    len = []
    squares.each { |s| len << values[s].length }
    width = 1 + len.max
    grid_line = ['-'*(width*3), '-'*(width*3), '-'*(width*3)].map { |k| "#{k}" }.join("+")
    row = ''

    rows.chars { |r|
      row.clear
      cols.chars { |c|
        row += values[r+c].center(width)
        ('36'.include? c) ? row += '|' : row += ''
      }
      puts row
      puts grid_line if 'CF'.include? r
    }
  end

end
