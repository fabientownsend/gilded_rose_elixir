defmodule Item do
  defstruct name: nil, sell_in: nil, quality: nil

  defmacro aged_brie?(name) do
    quote do: unquote(name) == "Aged Brie"
  end

  defmacro hand_of_ragnaros?(name) do
    quote do: unquote(name) == "Hand of Ragnaros"
  end

  defmacro backstage?(name) do
    quote do: unquote(name) == "Backstage passes to a TAFKAL80ETC concert"
  end
end

defprotocol Itemm do
  def size(item)
end

defimpl Itemm, for: Item do
  def size(%{name: n} = item) when n == "Aged Brie" , do: 1
  def size({"Hand of Ragnaros", s, q}) when s < 0 and q > 1, do: -2
end
