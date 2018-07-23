defmodule ExBanking do
  @moduledoc """
  Documentation for ExBanking.
  """

  def create_user(name) do
    GenServer.call(ExBanking.Worker, {:new_user, name})
  end

  def deposit(name, amount, currency) do
    GenServer.call(ExBanking.Worker, {:deposit, name, amount, currency})
  end

  def cleanup, do: GenServer.call(ExBanking.Worker, :cleanup)
end
