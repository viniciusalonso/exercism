defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    matrix =
      input
      |> String.split(~r/\n/)
      |> Enum.map(fn a ->
        String.split(a)
        |> Enum.map(&String.to_integer/1)
      end)

    %Matrix{matrix: matrix}
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%Matrix{matrix: matrix}) do
    matrix
    |> Enum.map(fn row -> Enum.join(row, " ") end)
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%Matrix{matrix: matrix}), do: matrix

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(%Matrix{matrix: matrix}, index) do
    matrix
    |> Enum.at(index - 1)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    for n <- 0..(length(rows(matrix)) - 1) do
      rows(matrix)
      |> Enum.map(fn row ->
        row
        |> Enum.with_index()
        |> Enum.at(n)
        |> (fn {val, _i} -> val end).()
      end)
    end
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(%Matrix{matrix: matrix}, index) do
    matrix
    |> Enum.map(fn row ->
      row
      |> Enum.with_index(1)
      |> Enum.filter(fn {_val, i} -> i == index end)
      |> Enum.map(fn {val, _} -> val end)
    end)
    |> List.flatten()
  end
end
