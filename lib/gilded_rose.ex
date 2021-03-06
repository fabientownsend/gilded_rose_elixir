defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  defp update_item(%{name: n} = item) when n == "Sulfuras", do: item
  defp update_item(item), do: item |> change_sell_in |> change_quality

  defp change_sell_in(item), do: %{item | sell_in: item.sell_in - 1}

  defp change_quality(item) do
    case item.name do
      "Aged Brie" -> quality(item, 1)
      "Hand of Ragnaros" -> update_hand_of_ragnaros(item)
      "Backstage passes to a TAFKAL80ETC concert" -> update_backstage(item)
    end
  end

  defp update_hand_of_ragnaros(%{sell_in: s, quality: q} = item) when s < 0 and q > 1 do
    quality(item, -2)
  end
  defp update_hand_of_ragnaros(item), do: quality(item, -1)

  defp update_backstage(%{sell_in: s} = item) when s < 0, do: quality(item, -item.quality)
  defp update_backstage(%{sell_in: s} = item) when s < 5, do: quality(item, 3)
  defp update_backstage(%{sell_in: s} = item) when s < 11, do: quality(item, 2)

  defp quality(%{quality: q} = item, value) when q >= 50 and value > 0, do: item
  defp quality(%{quality: q} = item, value) when q <= 0, do: item
  defp quality(item, value), do: %{item | quality: item.quality + value}
end
