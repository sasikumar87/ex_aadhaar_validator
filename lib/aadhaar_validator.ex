defmodule AadhaarValidator do
  @dihedral_group [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
    [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
    [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
    [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
    [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
    [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
    [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
    [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
    [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
  ]

  @permutation [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
    [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
    [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
    [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
    [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
    [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
    [7, 0, 4, 6, 9, 1, 3, 2, 5, 8]
  ]

  @inverse ["0", "4", "3", "2", "1", "5", "6", "7", "8", "9"]

  def checksum_of(card_num) when is_integer(card_num) do
    card_num
    |> Integer.to_string()
    |> checksum_of()
    |> String.to_integer()
  end
  def checksum_of(card_num) when is_binary(card_num) do
    _ = String.to_integer(card_num) # To check all numbers
    case String.length(card_num) do
      11 ->
        index = card_num
        |> String.codepoints()
        |> Enum.reverse()
        |> Enum.with_index()
        |> Enum.reduce(0, fn({x, i}, check) ->
          second_arg =
            @permutation
            |> Enum.at(rem(i + 1, 8))
            |> Enum.at(String.to_integer(x))
          @dihedral_group
          |> Enum.at(check)
          |> Enum.at(second_arg)
         end)
        Enum.at(@inverse, index)

      _ ->
        raise ArgumentError.exception("Not a valid number to calculate checksum")
    end
  end

  def valid?(number) when is_integer(number) do
    number
    |> Integer.to_string()
    |> valid?()
  end
  def valid?(number) when is_binary(number) do
    _ = String.to_integer(number) # To check all numbers
    case String.length(number) do
      12 ->
        {card_num, checksum} = String.split_at(number, -1)
        valid?(card_num, checksum)
      _ ->
        false
    end
  end

  defp valid?(card_num, checksum) do
    checksum_of(card_num) == checksum
  end
end
