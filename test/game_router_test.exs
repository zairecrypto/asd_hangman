defmodule GameRouterTest do
  use ExUnit.Case
  use Plug.Test

  @opts GameRouter.init([])

  test "initialise Cowboy2" do
    {_status, pid} = GameRouter.start_link()
    assert is_pid pid 
  end

  test "Reports path / is not served by the application" do
    # initialize all the infrastructure to establish a connection 
    # with the web application using the verb :get on the URL (or path) /
    conn = conn(:get, "/")
    conn = GameRouter.call(conn, @opts)
    assert conn.status == 404
    assert conn.resp_body == "Oops"
  end

  test "Game URL is unknown" do
    conn = conn(:get, "/games/:id") |> GameRouter.call(@opts)    
    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "Game URL is unknown"
  end


  test "
  GET on /games/:id (e.g. /games/123) to retrieve the current state
  of the corresponding game
  " do
    id_atom = String.to_atom(UUID.uuid1())

    {:ok, _pid} = Game.start_link id_atom
    conn = conn(:get, "/games/#{id_atom}") |> GameRouter.call(@opts)
    assert conn.status == 200
  end

  # test "Your game has been created" do 
  #   id = UUID.uuid1()
  #   {:ok, _} = Game.start_link(String.to_atom(id))
  #   # conn = conn(:post, "/games") |> put_req_header("Location", "/games/#{id}")
  #   assert true
  # end

end