require 'test/unit'

class AppHelperTest < Test::Unit::TestCase
  require_relative 'app_helper'

  # Called before every test method runs.
  def setup
    # Do nothing
    @digits   = '123456789'
    @rows     = 'ABCDEFGHI'
    @cols     =  @digits
    @squares = AppHelper.cross_prod(@rows, @cols)
    @unitlist = AppHelper.unitlist(@rows, @cols)
    @units = AppHelper.units(@unitlist,@squares)
    @peers = AppHelper.peers(@units,@squares)
  end

  def test_squares
    assert_equal(81,@squares.length)
  end

  def test_unitlist
    assert_equal(27,@unitlist.length)
  end

  def test_units
    @squares.each { |s| assert_equal(3,@units[s].length) }
  end

  def test_peers
    @squares.each { |s| assert_equal(20,@peers[s].length) }
  end

  def test_d4_units
    expected_units = [%w(A4 B4 C4 D4 E4 F4 G4 H4 I4),
                      %w(D1 D2 D3 D4 D5 D6 D7 D8 D9),
                      %w(D4 D5 D6 E4 E5 E6 F4 F5 F6)]

    assert_equal(expected_units,@units['D4'])
  end

  def test_d4_peers
    expected_peers = %w(A4 B4 C4 E4 F4 G4 H4 I4 D1 D2
                        D3 D5 D6 D7 D8 D9 E5 E6 F5 F6)

    assert_equal(expected_peers,@peers['D4'])
  end

end