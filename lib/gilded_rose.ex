defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  @one_day 1

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  defp update_item(%{name: n} = item) when n == "Sulfuras", do: item
  defp update_item(item), do: item |> change_sell_in |> change_quality

  defp change_sell_in(item), do: %{item | sell_in: item.sell_in - @one_day}

  defp change_quality(item) do
    case item.name do
      "Aged Brie" -> add_quality(1, item)
      "Hand of Ragnaros" -> ragnaros_quality_change(item) |> add_quality(item)
      "Backstage passes to a TAFKAL80ETC concert" -> backstage_quality_change(item) |> add_quality(item)
    end
  end

  defp ragnaros_quality_change(%{sell_in: s, quality: q}) when s < 0 and q > 1, do: -2
  defp ragnaros_quality_change(_), do: -1

  defp backstage_quality_change(%{sell_in: s} = item) when s < 0, do: -item.quality
  defp backstage_quality_change(%{sell_in: s}) when s < 5, do: 3
  defp backstage_quality_change(%{sell_in: s}) when s < 11, do: 2

  defp add_quality(value, %{quality: q} = item) when q >= 50 and value > 0, do: item
  defp add_quality(_, %{quality: q} = item) when q <= 0, do: item
  defp add_quality(value, item), do: %{item | quality: item.quality + value}
end
