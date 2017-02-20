defmodule CatchAll.Header do
  use Ecto.Schema

  embedded_schema do
    field :name, :string
    field :value, :string
  end
end