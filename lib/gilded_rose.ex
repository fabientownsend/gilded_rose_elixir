defmodule GildedRose do
  import Item
  import Itemm
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

  defp change_quality(item), do: estimate_change(item) |> add_quality(item)

  defp estimate_change(%{name: n} = item) when aged_brie?(n), do: Itemm.size(item)
  defp estimate_change(%{name: n, sell_in: s, quality: q} = item) when hand_of_ragnaros?(n) and s < 0 and q > 1, do: Itemm.size(item)
  defp estimate_change(%{name: n}) when hand_of_ragnaros?(n), do: -1
  defp estimate_change(%{name: n, sell_in: s} = item) when backstage?(n) and s < 0, do: -item.quality
  defp estimate_change(%{name: n, sell_in: s}) when backstage?(n) and s < 5, do: 3
  defp estimate_change(%{name: n, sell_in: s}) when backstage?(n) and s < 11, do: 2

  defp add_quality(value, %{quality: q} = item) when q >= 50 and value > 0, do: item
  defp add_quality(_, %{quality: q} = item) when q <= 0, do: item
  defp add_quality(value, item), do: %{item | quality: item.quality + value}
end
