defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(item) do
    item = decrease_sell_in(item)

    cond do
      is_legendary?(item) -> item
      is_backstage_passe?(item) -> update_backstage(item)
      item.name == "Aged Brie" -> increase_quality(item, 1)
      item.name == "Hand of Ragnaros" -> update_hand_of_ragnaros(item)
    end
  end

  def decrease_sell_in(item) do
    cond do
      !is_legendary?(item) -> %{item | sell_in: item.sell_in - 1}
      true -> item
    end
  end

  def is_legendary?(item), do: item.name == "Sulfuras"
  def is_backstage_passe?(item), do: item.name == "Backstage passes to a TAFKAL80ETC concert"

  def update_backstage(item) do
    cond do
      item.sell_in < 0 -> decrease_quality(item, item.quality)
      item.sell_in < 5 -> increase_quality(item, 3)
      item.sell_in < 11 -> increase_quality(item, 2)
    end
  end

  def update_hand_of_ragnaros(item) do
    cond do
      item.sell_in < 0 -> decrease_quality(item, 2)
      true -> decrease_quality(item, 1)
    end
  end

  def decrease_quality(%{quality: q} = item, value) when q > 0 do
    %{item | quality: item.quality - value}
  end
  def decrease_quality(item, _), do: item

  def increase_quality(%{quality: q} = item, value) when q < 50 do
    %{item | quality: item.quality + value}
  end
  def increase_quality(item, _), do: item
end
