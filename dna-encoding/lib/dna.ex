defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  def encode(dna) do
    # Enum.each(
    #   dna,
    #   &(IO.puts "V>>>>>>>>>> Val=#{encode_nucleotide(&1)}")
    # )

    #
    Enum.reduce(
      dna,
      << >>,
      fn c, acc -> IO.puts ">>>>>>>> #{}"



      #&(<<&2, encode_nucleotide(&1)::size(4)>>)
    )
  end

  def decode(dna) do
    # Please implement the decode/1 function
  end
end
