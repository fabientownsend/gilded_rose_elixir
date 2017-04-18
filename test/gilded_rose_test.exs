defmodule GildedRoseTest do
  use ExUnit.Case

  test "begin the journey of refactoring" do
    item = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]
    result = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 7, quality: 5}]
    assert GildedRose.update_quality(item) == result
  end
end
