defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts) :: {:ok, opts} | {:error, error}

  @callback handle_frame(dot(), pos_integer(), opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, pos_integer, _) do
    if rem(pos_integer, 4) == 0 do
      %{dot | opacity: dot.opacity / 2}
    else
      dot
    end
  end
end

defmodule DancingDots.Zoom do
  @behaviour DancingDots.Animation

  @impl true
  def init(opts) do
    v = opts[:velocity]

    cond do
      is_number(v) ->
        {:ok, opts}

      true ->
        {:error,
         "The :velocity option is required, and its value must be a number. Got: #{inspect(v)}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, pos_integer, opts) do
    %{dot | radius: dot.radius + (pos_integer - 1) * opts[:velocity]}
  end
end
