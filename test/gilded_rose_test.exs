defmodule GildedRoseTest do
  use ExUnit.Case

  test "hand of ragnaros quality degrades by 1 for one day passed" do
    hand_of_ragnaros = [%Item{name: "Hand of Ragnaros", sell_in: 4, quality: 3}]
    updated_hand_of_ragnaros = [%Item{name: "Hand of Ragnaros", sell_in: 3, quality: 2}]

    assert GildedRose.update_quality(hand_of_ragnaros) == updated_hand_of_ragnaros
  end

  test "once the sell by date has passed, hand of ragnaros quality degrades twice as fast" do
    passed_hand_of_ragnaros = [%Item{name: "Hand of Ragnaros", sell_in: 0, quality: 6}]
    updated_hand_of_ragnaros = [%Item{name: "Hand of Ragnaros", sell_in: -1, quality: 4}]

    assert GildedRose.update_quality(passed_hand_of_ragnaros) == updated_hand_of_ragnaros
  end

  test "the quality of an hand of ragnaros is never negative" do
    hand_of_ragnaros = [%Item{name: "Hand of Ragnaros", sell_in: 0, quality: 0}]
    updated_hand_of_ragnaros = [%Item{name: "Hand of Ragnaros", sell_in: -1, quality: 0}]

    assert GildedRose.update_quality(hand_of_ragnaros) == updated_hand_of_ragnaros
  end
end
