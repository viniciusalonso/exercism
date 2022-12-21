defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    move_consonants(word) <> "ay"
  end

  defguardp is_vowel(char) when char in 'aeiou'

  defp move_consonants(word) do
    case word do
      # If the first letter is a vowel, we return the word.
      # Special cases: "x" or "y" followed by a consonant counts as a vowel.
      <<"x", ch>> <> _ when not is_vowel(ch) -> word
      <<"y", ch>> <> _ when not is_vowel(ch) -> word
      <<ch>> <> _ when is_vowel(ch) -> word
      # If the first letter is a consonant, we move it to the end and recurse.
      # Special case: "qu" counts as a consonant.
      "qu" <> suf -> move_consonants(suf <> "qu")
      <<cons>> <> suf -> move_consonants(suf <> <<cons>>)
    end
  end
end
