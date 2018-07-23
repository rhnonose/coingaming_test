defmodule ExBanking.AccountCreator do

  def create_account(username) when is_binary(username) do
    {:ok, %{"BRL" => 0, "USD" => 0}}
  end

  def can_it_be_created("", _state), do: {:error, :wrong_arguments}

  def can_it_be_created(username, state) when is_binary(username) do
    case Map.get(state, username) do
      nil -> :ok
      _username -> {:error, :user_already_exists}
    end
  end

  def can_it_be_created(_username, _state), do: {:error, :wrong_arguments}
end
