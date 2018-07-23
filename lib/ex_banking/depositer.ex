defmodule ExBanking.Depositer do

  def can_it_be_deposited(username, state) do
    case Map.get(state, username) do
      nil -> {:error, :user_does_not_exist}
      _user -> :ok
    end
  end

  def deposit(username, amount, currency, state) do
    updated_account =
      state
      |> Map.get(username)
      |> Map.update(currency, amount, &do_deposit(&1, amount))

    new_state = Map.put(state, username, updated_account)

    {:ok, Map.get(updated_account, currency), new_state}
  end

  defp do_deposit(current_amount, new_amount), do: current_amount + new_amount
end
