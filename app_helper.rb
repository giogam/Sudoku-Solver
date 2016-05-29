
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
