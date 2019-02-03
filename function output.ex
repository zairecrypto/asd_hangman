iex(10)> use Plug.Test
iex(10)> conn = conn(:get, "/")
%Plug.Conn{
  adapter: {Plug.Adapters.Test.Conn, :...},
  assigns: %{},
  before_send: [],
  body_params: %Plug.Conn.Unfetched{aspect: :body_params},
  cookies: %Plug.Conn.Unfetched{aspect: :cookies},
  halted: false,
  host: "www.example.com",
  method: "GET",
  owner: #PID<0.224.0>,
  params: %Plug.Conn.Unfetched{aspect: :params},
  path_info: [],
  path_params: %{},
  port: 80,
  private: %{},
  query_params: %Plug.Conn.Unfetched{aspect: :query_params},
  query_string: "",
  remote_ip: {127, 0, 0, 1},
  req_cookies: %Plug.Conn.Unfetched{aspect: :cookies},
  req_headers: [],
  request_path: "/",
  resp_body: nil,
  resp_cookies: %{},
  resp_headers: [{"cache-control", "max-age=0, private, must-revalidate"}],
  scheme: :http,
  script_name: [],
  secret_key_base: nil,
  state: :unset,
  status: nil
}

# -------------------------------

iex(11)> conn = GameRouter.call(conn, GameRouter.init([]))
%Plug.Conn{
  adapter: {Plug.Adapters.Test.Conn, :...},
  assigns: %{},
  before_send: [],
  body_params: %{},
  cookies: %Plug.Conn.Unfetched{aspect: :cookies},
  halted: false,
  host: "www.example.com",
  method: "GET",
  owner: #PID<0.224.0>,
  params: %{},
  path_info: [],
  path_params: %{},
  port: 80,
  private: %{
    plug_route: {"/*_path", #Function<7.12962284/1 in GameRouter.do_match/4>}
  },
  query_params: %{},
  query_string: "",
  remote_ip: {127, 0, 0, 1},
  req_cookies: %Plug.Conn.Unfetched{aspect: :cookies},
  req_headers: [],
  request_path: "/",
  resp_body: "Oops",
  resp_cookies: %{},
  resp_headers: [{"cache-control", "max-age=0, private, must-revalidate"}],
  scheme: :http,
  script_name: [],
  secret_key_base: nil,
  state: :sent,
  status: 404
}


# ------------------------

    # initialize all the infrastructure to establish a connection 
    # with the web application using the verb :post on the URL (/games)

iex(12)> conn = conn(:post, "/games")
%Plug.Conn{
  adapter: {Plug.Adapters.Test.Conn, :...},
  assigns: %{},
  before_send: [],
  body_params: %Plug.Conn.Unfetched{aspect: :body_params},
  cookies: %Plug.Conn.Unfetched{aspect: :cookies},
  halted: false,
  host: "www.example.com",
  method: "POST",
  owner: #PID<0.224.0>,
  params: %Plug.Conn.Unfetched{aspect: :params},
  path_info: ["games"],
  path_params: %{},
  port: 80,
  private: %{},
  query_params: %Plug.Conn.Unfetched{aspect: :query_params},
  query_string: "",
  remote_ip: {127, 0, 0, 1},
  req_cookies: %Plug.Conn.Unfetched{aspect: :cookies},
  req_headers: [],
  request_path: "/games",
  resp_body: nil,
  resp_cookies: %{},
  resp_headers: [{"cache-control", "max-age=0, private, must-revalidate"}],
  scheme: :http,
  script_name: [],
  secret_key_base: nil,
  state: :unset,
  status: nil
}