defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(item) do
    item = cond do
      is_legendary?(item) -> item
      item.name != "Aged Brie" && !is_backstage_passe?(item) ->
        if item.quality > 0 do
          decrease_quality(item)
        else
          item
        end
      true ->
        cond do
          item.quality < 50 ->
            item = %{item | quality: item.quality + 1}
            cond do
              is_backstage_passe?(item) ->
                item = cond do
                  item.sell_in < 11 ->
                    cond do
                      item.quality < 50 ->
                        %{item | quality: item.quality + 1}
                      true -> item
                    end
                  true -> item
                end
                cond do
                  item.sell_in < 6 ->
                    cond do
                      item.quality < 50 ->
                        %{item | quality: item.quality + 1}
                      true -> item
                    end
                  true -> item
                end
              true -> item
            end
          true -> item
        end
    end

    item = decrease_sell_in(item)

    cond do
      is_legendary?(item) -> item
      item.name == "Aged Brie" -> item
      item.sell_in < 0 &&  is_backstage_passe?(item) -> drop_quality_to_zerro(item)
      item.sell_in < 0 && item.quality > 0 -> decrease_quality(item)
      true -> item
    end
  end

  def is_legendary?(item), do: item.name == "Sulfuras"
  def is_backstage_passe?(item), do: item.name == "Backstage passes to a TAFKAL80ETC concert"
  def decrease_quality(item), do: %{item | quality: item.quality - 1}
  def drop_quality_to_zerro(item), do: %{item | quality: 0}

  def decrease_sell_in(item) do
    cond do
      !is_legendary?(item) -> %{item | sell_in: item.sell_in - 1}
      true -> item
    end
  end
end
