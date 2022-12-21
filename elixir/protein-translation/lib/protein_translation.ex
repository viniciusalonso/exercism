defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  def of_rna(rna, acc \\ [])
  def of_rna("", acc), do: {:ok, acc}

  def of_rna(rna, acc) do
    [head | tail] = String.split(rna, ~r/.{3}/, include_captures: true, trim: true)

    case of_codon(head) do
      {:error, _message} -> {:error, "invalid RNA"}
      {:ok, "STOP"} -> of_rna("", acc)
      {:ok, codon} -> of_rna(Enum.join(tail), acc ++ [codon])
    end
  end

  # ProteinTranslation.of_rna "UUCUUCUAAUGGU"
  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    cond do
      codon in ["UGU", "UGC"] -> {:ok, "Cysteine"}
      codon in ["UUA", "UUG"] -> {:ok, "Leucine"}
      codon in ["UUU", "UUC"] -> {:ok, "Phenylalanine"}
      codon in ["UCU", "UCC", "UCA", "UCG"] -> {:ok, "Serine"}
      codon in ["UAU", "UAC"] -> {:ok, "Tyrosine"}
      codon in ["UAA", "UAG", "UGA"] -> {:ok, "STOP"}
      codon === "UGG" -> {:ok, "Tryptophan"}
      codon === "AUG" -> {:ok, "Methionine"}
      true -> {:error, "invalid codon"}
    end
  end

  # ProteinTranslation.of_codon "UGUUGC"
end
