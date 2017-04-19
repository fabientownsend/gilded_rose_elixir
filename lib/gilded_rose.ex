defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%{name: n} = item) when n == "Sulfuras", do: item
  def update_item(item) do
    item = decrease_sell_in(item)

    cond do
      item.name == "Backstage passes to a TAFKAL80ETC concert" -> update_backstage(item)
      item.name == "Aged Brie" -> increase_quality(item, 1)
      item.name == "Hand of Ragnaros" -> update_hand_of_ragnaros(item)
    end
  end

  def decrease_sell_in(item), do: %{item | sell_in: item.sell_in - 1}

  def update_backstage(item) do
    cond do
      item.sell_in < 0 -> decrease_quality(item, item.quality)
      item.sell_in < 5 -> increase_quality(item, 3)
      item.sell_in < 11 -> increase_quality(item, 2)
    end
  end

  def update_hand_of_ragnaros(item) do
    cond do
      item.sell_in < 0 and item.quality > 1 -> decrease_quality(item, 2)
      true -> decrease_quality(item, 1)
    end
  end

  def decrease_quality(%{quality: q} = item, value) when q > 0, do: quality(item, -value)
  def decrease_quality(item, _), do: item

  def increase_quality(%{quality: q} = item, value) when q < 50, do: quality(item, value)
  def increase_quality(item, _), do: item

  def quality(item, value), do: %{item | quality: item.quality + value}
end
