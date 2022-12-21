defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts) :: {:ok, opts} | {:error, error}
  @callback handle_frame(dot, frame_number, opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation

      def init(opts) do
        {:ok, opts}
      end

      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _opts) when rem(frame_number, 4) == 0 do
    %DancingDots.Dot{dot | opacity: dot.opacity / 2}
  end

  @impl DancingDots.Animation
  def handle_frame(dot, _frame_number, _opts), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(velocity: velocity) when is_integer(velocity), do: {:ok, [velocity: velocity]}

  @impl DancingDots.Animation
  def init([]),
    do: {:error, "The :velocity option is required, and its value must be a number. Got: nil"}

  @impl DancingDots.Animation
  def init(velocity: velocity) do
    {:error,
     "The :velocity option is required, and its value must be a number. Got: \"#{velocity}\""}
  end

  @impl DancingDots.Animation
  def handle_frame(dot, 1, _opts), do: dot

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, velocity: velocity) do
    new_radius = dot.radius + (frame_number - 1) * velocity
    %DancingDots.Dot{dot | radius: new_radius}
  end
end
