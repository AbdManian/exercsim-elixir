defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast = {:def, _, body}, acc) do
    {ast, [get_name(body) | acc]}
  end

  def decode_secret_message_part(ast = {:defp, _, body}, acc) do
    {ast, [get_name(body) | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  defp func_name_cipher(_, nil), do: ""

  defp func_name_cipher(f_atom, args),
    do: f_atom |> Atom.to_string() |> String.slice(0, length(args))

  defp get_name([{:when, _, [f_dec | _]} | _]), do: get_name([f_dec])
  defp get_name([{fname, _, args} | _]), do: func_name_cipher(fname, args)

  def decode_secret_message(string) do

    IO.inspect(to_ast(string))

    {:defmodule, _,
     [
       _,
       [
         do: {_, _, func_list}
       ]
     ]} = to_ast(string)


    func_list
    |> Enum.map(& IO.inspect(&1, label: ">>>>>>>>>>>>>>>>>>>>>"))
    |> Enum.map(&decode_secret_message_part(&1, []))
    |> Enum.map(fn {_, x} -> x end)
    |> Enum.concat()
    |> Enum.join()



#     {:defmodule, [line: 12],
#     [
#       {:__aliases__, [line: 12], [:ASTHelpers]},
#       [
#         do: {:__block__, [],
#          [
#            {:def, [line: 13],
#             [
#               {:submodule?, [line: 13],
#                [
#                  {:m, [line: 13], nil},
#                  {:_f, [line: 13], nil},
#                  {:_args, [line: 13], nil}
#                ]},
#               [
#                 do: {{:., [line: 13],
#                   [{:__aliases__, [line: 13], [:String]}, :contains?]},
#                  [line: 13], [{:m, [line: 13], nil}, "."]}
#               ]
#             ]},
#            {:def, [line: 14],
#             [
#               {:module, [line: 14],
#                [
#                  {:{}, [line: 14],
#                   [
#                     {:m, [line: 14], nil},
#                     {:_f, [line: 14], nil},
#                     {:_args, [line: 14], nil}
#                   ]}
#                ]},
#               [do: {:m, [line: 14], nil}]
#             ]},
#            {:def, [line: 15],
#             [
#               {:arity, [line: 15],
#                [
#                  {:_m, [line: 15], nil},
#                  {:_f, [line: 15], nil},
#                  {:args, [line: 15], nil}
#                ]},
#               [do: {:length, [line: 15], [{:args, [line: 15], nil}]}]
#             ]},
#            {:defp, [line: 16],
#             [
#               {:when, [line: 16],
#                [
#                  {:nested?, [line: 16],
#                   [{:x, [line: 16], nil}, {:y, [line: 16], nil}]},
#                  {:is_list, [line: 16], [{:y, [line: 16], nil}]}
#                ]},
#               [
#                 do: {:in, [line: 16],
#                  [{:x, [line: 16], nil}, {:y, [line: 16], nil}]}
#               ]
#             ]}
#          ]}
#       ]
#     ]}
#  ]}



#     {:defmodule, [line: 1],
#     [
#       {:__aliases__, [line: 1], [:Notebook]},
#       [
#         do: {:def, [line: 2],
#          [
#            {:note, [line: 2],
#             [{:notebook, [line: 2], nil}, {:text, [line: 2], nil}]},
#            [
#              do: {:add_to_notebook, [line: 3],
#               [
#                 {:notebook, [line: 3], nil},
#                 {:text, [line: 3], nil},
#                 [append: true]
#               ]}
#            ]
#          ]}
#       ]
#     ]}

#     {:defmodule, [line: 1],
#     [
#       {:__aliases__, [line: 1], [:Notebook]},
#       [
#         do: {:def, [line: 2],
#          [
#            {:note, [line: 2],
#             [
#               {:notebook, [line: 2], nil},
#               {:text, [line: 2], nil}
#             ]},
#            [
#              do: {:add_to_notebook, [line: 3],
#               [
#                 {:notebook, [line: 3], nil},
#                 {:text, [line: 3], nil},
#                 [append: true]
#               ]}
#            ]
#          ]}
#       ]
#     ]}











  end
end
