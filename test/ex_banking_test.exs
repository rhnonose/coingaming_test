defmodule ExBankingTest do
  use ExUnit.Case
  doctest ExBanking

  describe "create_user/1" do
    test "should create a user" do
      ExBanking.cleanup()
      assert :ok == ExBanking.create_user("rodrigo")
    end

    test "should error with wrong_arguments" do
      ExBanking.cleanup()
      assert {:error, :wrong_arguments} == ExBanking.create_user("")
    end

    test "should error with user_already_exists" do
      ExBanking.cleanup()
      ExBanking.create_user("rodrigo")
      assert {:error, :user_already_exists} == ExBanking.create_user("rodrigo")
    end
  end

  describe "deposit/3" do
    test "should increase the amount from zero" do
      ExBanking.cleanup()
      ExBanking.create_user("rodrigo")

      assert {:ok, 10} == ExBanking.deposit("rodrigo", 10, "BRL")
      assert {:ok, 30} == ExBanking.deposit("rodrigo", 20, "BRL")

      assert {:ok, 10} == ExBanking.deposit("rodrigo", 10, "USD")
      assert {:ok, 30} == ExBanking.deposit("rodrigo", 20, "USD")
    end
    test "should error with user_does_not_exist" do
      ExBanking.cleanup()

      assert {:error, :user_does_not_exist} == ExBanking.deposit("bla", 10, "BRL")
    end
  end


    # test "should error with not_enough_money" do
    #   assert {:error, :not_enough_money} == ExBanking.create_user("")
    # end

    # test "should error with sender_does_not_exist" do
    #   assert {:error, :sender_does_not_exist} == ExBanking.create_user("")
    # end

    # test "should error with receiver_does_not_exist" do
    #   assert {:error, :receiver_does_not_exist} == ExBanking.create_user("")
    # end

    # test "should error with too_many_requests_to_user" do
    #   assert {:error, :too_many_requests_to_user} == ExBanking.create_user("")
    # end

    # test "should error with too_many_requests_to_sender" do
    #   assert {:error, :too_many_requests_to_sender} == ExBanking.create_user("")
    # end

    # test "should error with too_many_requests_to_receiver" do
    #   assert {:error, :too_many_requests_to_receiver} == ExBanking.create_user("")
    # end

  describe "withdraw/3" do

  end


  describe "get_balance/2" do

  end


  describe "send/4" do

  end

end
