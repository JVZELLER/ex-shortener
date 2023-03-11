defmodule ExShortener.Keys.Commands.EncodeB62 do
  @moduledoc """
  B62 encode algorithm to generate keys values to replace long URLs.
  """
  @numbers Enum.to_list(?0..?9)
  @lower_case_letters Enum.to_list(?a..?z)
  @capital_letters Enum.to_list(?A..?Z)

  @base_62_alphabet @numbers
                    |> Kernel.++(@lower_case_letters)
                    |> Kernel.++(@capital_letters)
                    |> Enum.with_index()
                    |> Enum.map(fn {elem, idx} -> {idx, List.to_string([elem])} end)
                    |> Map.new()

  @spec execute(integer()) :: String.t()
  def execute(number) do
    number
    |> do_encode("")
    |> IO.iodata_to_binary()
  end

  defp do_encode(dividend, acc) when dividend > 0 do
    remainder = rem(dividend, 62)
    new_dividend = div(dividend, 62)

    do_encode(new_dividend, [acc | @base_62_alphabet[remainder]])
  end

  defp do_encode(_dividend, acc), do: acc
end
