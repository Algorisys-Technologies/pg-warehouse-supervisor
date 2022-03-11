# Warehouse

# pg-warehouse-supervisor

# How to run:-
  1. iex -S mix
  2. packages = Warehouse.Package.random_batch(50)
  3. Warehouse.Receiver.receive_packages(packages)

# To check the state of DeliveratorPool module:-
  4. :sys.get_state(Warehouse.DeliveratorPool)
  5. deliver = :sys.get_state(Warehouse.Receiver)

# To check all the packages delivered successfully:-
  6. packages |> Enum.sort_by(&(&1.id)) == deliver.delivered_packages |> Enum.sort_by(&(&1.id))
  