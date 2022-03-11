defmodule Warehouse.Package do
  @doc """
  How to run:-
  1. iex -S mix
  2. packages = Warehouse.Package.random_batch(50)
  3. Warehouse.Receiver.receive_packages(packages)
  4. :sys.get_state(Warehouse.DeliveratorPool)
  5. deliver = :sys.get_state(Warehouse.Receiver)
  6. packages |> Enum.sort_by(&(&1.id)) == deliver.delivered_packages |> Enum.sort_by(&(&1.id))
  """

  defstruct [:id, :contents]
  alias Warehouse.Package

  def new(contents) do
    %Package{
      id: generate_package_id(),
      contents: contents
    }
  end

  def random do
    content_options = ["Bat", "Ball", "Book", "Broom"]
    content_options |> Enum.random() |> new
  end

  def random_batch(n), do: Stream.repeatedly(&Package.random/0) |> Enum.take(n)

  # this will generate a string like "MBE56YXTVM"
  # for use as an id.  Use uuid module for actual things
  defp generate_package_id do
    :crypto.strong_rand_bytes(10)
    |> Base.url_encode64()
    |> binary_part(0, 10)
    |> String.upcase()
    |> String.replace(~r/[-_]/, "X")
  end
end
