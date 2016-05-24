
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

end


################ Unit Tests ################
=begin
p squares.length == 81

p ulist.length == 27

squares.each do |s|
  p units[s].length == 3
end

squares.each do |s|
  p peers[s].length == 20
end


p units['C2'] == [['A2', 'B2', 'C2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2'],
                  ['C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9'],
                  ['A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3']
                 ]

p peers['C2'] == ['A2', 'B2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2',
                  'C1', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9',
                  'A1', 'A3', 'B1', 'B3']

=end
################ Parse a Grid ################
