defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  defp update_item(item) do
    case item.name do
      "Sulfuras" -> item
      "Aged Brie" -> item |> update_sell_in |> increase_quality(1)
      "Hand of Ragnaros" -> item |> update_sell_in |> update_hand_of_ragnaros
      "Backstage passes to a TAFKAL80ETC concert" -> item |> update_sell_in |> update_backstage
    end
  end

  defp update_sell_in(item), do: %{item | sell_in: item.sell_in - 1}

  defp update_backstage(%{sell_in: s} = item) when s < 0, do: decrease_quality(item, item.quality)
  defp update_backstage(%{sell_in: s} = item) when s < 5, do: increase_quality(item, 3)
  defp update_backstage(%{sell_in: s} = item) when s < 11, do: increase_quality(item, 2)

  defp update_hand_of_ragnaros(%{sell_in: s, quality: q} = item) when s < 0 and q > 1 do
    decrease_quality(item, 2)
  end
  defp update_hand_of_ragnaros(item), do: decrease_quality(item, 1)

  defp decrease_quality(%{quality: q} = item, value) when q > 0, do: quality(item, -value)
  defp decrease_quality(item, _), do: item

  defp increase_quality(%{quality: q} = item, value) when q < 50, do: quality(item, value)
  defp increase_quality(item, _), do: item

  defp quality(item, value), do: %{item | quality: item.quality + value}
end
