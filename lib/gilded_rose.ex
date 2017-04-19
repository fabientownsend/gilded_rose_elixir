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
      item.name == "Aged Brie" -> increase_quality(item)
      true -> decrease_quality(item)
    end
  end

  def decrease_quality(item) do
    cond do
      item.sell_in < 0 && item.quality > 0 -> %{item | quality: item.quality - 2}
      item.quality > 0 -> %{item | quality: item.quality - 1}
      true -> item
    end
  end

  def is_legendary?(item), do: item.name == "Sulfuras"
  def is_backstage_passe?(item), do: item.name == "Backstage passes to a TAFKAL80ETC concert"
  def drop_quality_to_zerro(item), do: %{item | quality: 0}

  def update_backstage(item) do
    cond do
      item.sell_in < 0 -> drop_quality_to_zerro(item)
      item.sell_in < 5 -> increase_quality(item, 3)
      item.sell_in < 11 -> increase_quality(item, 2)
    end
  end

  def increase_quality(item), do: increase_quality(item, 1)
  def increase_quality(item, value) do
    cond do
      item.quality < 50 -> %{item | quality: item.quality + value}
      true -> item
    end
  end

  def decrease_sell_in(item) do
    cond do
      !is_legendary?(item) -> %{item | sell_in: item.sell_in - 1}
      true -> item
    end
  end
end
