defmodule CatchAll.EmailTest do
  use CatchAll.ModelCase

  alias CatchAll.Email

  @valid_attrs %{data: "some content", from: "some content", to: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Email.changeset(%Email{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Email.changeset(%Email{}, @invalid_attrs)
    refute changeset.valid?
  end
end
