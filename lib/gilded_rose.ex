defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  @one_day 1

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  defp update_item(%{name: n} = item) when n == "Sulfuras", do: item
  defp update_item(item) do
    item = change_sell_in(item)
    %{sell_in: s, name: n, quality: q} = item
    change_quality(item, calcul_change(n, s, q))
  end

  defp change_sell_in(item), do: %{item | sell_in: item.sell_in - @one_day}

  defp calcul_change("Hand of Ragnaros", sell_in, quality) when sell_in < 0 and quality > 1, do: -2
  defp calcul_change("Hand of Ragnaros", _, _), do: -1
  defp calcul_change("Aged Brie", _, _), do: 1
  defp calcul_change("Backstage passes to a TAFKAL80ETC concert", sell_in, quality) when sell_in < 0, do: -quality
  defp calcul_change("Backstage passes to a TAFKAL80ETC concert", sell_in, _) when sell_in < 5, do: 3
  defp calcul_change("Backstage passes to a TAFKAL80ETC concert", sell_in, _) when sell_in < 11, do: 2

  defp change_quality(%{quality: q} = item, value) when q >= 50 and value > 0, do: item
  defp change_quality(%{quality: q} = item, _) when q <= 0, do: item
  defp change_quality(item, value), do: %{item | quality: item.quality + value}
end
