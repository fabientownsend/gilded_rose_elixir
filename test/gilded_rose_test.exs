defmodule GildedRoseTest do
  use ExUnit.Case

  test "hand of ragnaros quality degrades by 1 for one day passed" do
    item = [%Item{name: "Hand of Ragnaros", sell_in: 4, quality: 3}]
    result = [%Item{name: "Hand of Ragnaros", sell_in: 3, quality: 2}]
    assert GildedRose.update_quality(item) == result
  end

  test "once the sell by date has passed, hand of ragnaros quality degrades twice as fast" do
    item = [%Item{name: "Hand of Ragnaros", sell_in: 0, quality: 6}]
    result = [%Item{name: "Hand of Ragnaros", sell_in: -1, quality: 4}]
    assert GildedRose.update_quality(item) == result
  end
end
