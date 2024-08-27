defmodule OpenMic.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OpenMic.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        name: "some name",
        start_time: ~N[2024-08-19 00:21:00]
      })
      |> OpenMic.Events.create_event()

    event
  end
end
