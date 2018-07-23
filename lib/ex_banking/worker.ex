defmodule ExBanking.Worker do

  alias ExBanking.{
    AccountCreator,
    Depositer
  }

  def child_spec(opts) do
      %{
        id: __MODULE__,
        start: {__MODULE__, :start_link, [opts]},
        type: :worker,
        restart: :permanent,
        shutdown: 500
      }
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts), do: {:ok, %{}}

  def handle_call({:new_user, username}, _caller, state) do
    with :ok <- AccountCreator.can_it_be_created(username, state),
         {:ok, account_content} <- AccountCreator.create_account(username) do
      {:reply, :ok, Map.put(state, username, account_content)}
    else
      error -> {:reply, error, state}
    end
  end

  def handle_call({:deposit, username, amount, currency}, _caller, state) do
    with :ok <- Depositer.can_it_be_deposited(username, state),
         {:ok, new_balance, new_state} <- Depositer.deposit(username, amount, currency, state) do
           {:reply, {:ok, new_balance}, new_state}
      else
        error -> {:reply, error, state}
    end
  end

  def handle_call(:state, _caller, state) do
    {:reply, state, state}
  end

  def handle_call(:cleanup, _caller, _state), do: {:reply, :ok, %{}}
end
