defmodule ExBanking do
  @moduledoc """
  Documentation for ExBanking.
  """

  def create_user(name) do
    GenServer.call(ExBanking.Worker, {:new_user, name})
  end

  def cleanup, do: GenServer.call(ExBanking.Worker, :cleanup)
end
