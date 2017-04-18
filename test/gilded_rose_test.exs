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

  test "aged brie increases in quality by one the older it gets" do
    aged_brie = [%Item{name: "Aged Brie", sell_in: 1, quality: 3}]
    updated_aged_brie = [%Item{name: "Aged Brie", sell_in: 0, quality: 4}]
    assert GildedRose.update_quality(aged_brie) == updated_aged_brie
  end

  test "aged brie quality is never more than 50" do
    aged_brie = [%Item{name: "Aged Brie", sell_in: 1, quality: 50}]
    updated_aged_brie = [%Item{name: "Aged Brie", sell_in: 0, quality: 50}]
    assert GildedRose.update_quality(aged_brie) == updated_aged_brie
  end

  test "backstage passes, increases in quality by 2 between 10 and 6 days" do
    days_left_to_test = [6, 7, 8, 9, 10]

     Enum.all?(days_left_to_test,
      fn(day_left) ->
        backstage_passes = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: day_left, quality: 5}]
        result = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: day_left - 1, quality: 7}]
        assert GildedRose.update_quality(backstage_passes) == result
      end
    )
  end

  test "backstage passes, increases in quality by 3 when there are 5 or less days" do
    days_left_to_test = [1, 2, 3, 4, 5]

    Enum.all?(days_left_to_test,
      fn(day_left) ->
        backstage_passes = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: day_left, quality: 5}]
        result = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: day_left - 1, quality: 8}]
        assert GildedRose.update_quality(backstage_passes) == result
      end
    )
  end

  test "backstage passes quality drop to zerro after the concert" do
    backstage_passes = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 50}]
    passed_backstage_passes = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: -1, quality: 0}]
    assert GildedRose.update_quality(backstage_passes) == passed_backstage_passes
  end
end
