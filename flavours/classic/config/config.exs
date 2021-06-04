import Config

flavour = System.get_env("BONFIRE_FLAVOUR", "flavours/classic")

#### Basic configuration

config :bonfire, Bonfire.Repo, priv: flavour <> "/repo"

# You probably won't want to touch these. You might override some in
# other config files.

config :bonfire,
  otp_app: :bonfire,
  env: config_env(),
  app_name: System.get_env("APP_NAME", "Bonfire"),
  repo_module: Bonfire.Repo,
  web_module: Bonfire.Web,
  endpoint_module: Bonfire.Web.Endpoint,
  mailer_module: Bonfire.Mailer,
  default_layout_module: Bonfire.Web.LayoutView,
  graphql_schema_module: Bonfire.GraphQL.Schema,
  user_schema: Bonfire.Data.Identity.User,
  org_schema: Bonfire.Data.Identity.User,
  home_page: Bonfire.Web.HomeLive,
  localisation_path: Path.expand("priv/localisation", File.cwd!()),
  ap_base_path: System.get_env("AP_BASE_PATH", "/pub"),
  signing_salt: "this-will-be-overriden-by-a-secure-string-in-runtime.exs",
  encryption_salt: "this-will-be-overriden-by-a-secure-string-in-runtime.exs"

config :bonfire, Bonfire.Web.Endpoint,
  url: [host: "localhost"],
  http: [
    port: String.to_integer(System.get_env("SERVER_PORT", "4000")), # this gets overriden in runtime.exs
    transport_options: [socket_opts: [:inet6]]
  ],
  render_errors: [view: Bonfire.Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Bonfire.PubSub

config :phoenix, :json_library, Jason

config :bonfire, :ecto_repos, [Bonfire.Repo]
config :bonfire, Bonfire.Repo, types: Bonfire.PostgresTypes

# ecto query filtering
# config :query_elf, :id_types, [:id, :binary_id, Pointers.ULID]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :bonfire, Oban,
  repo: Bonfire.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [
    federator_incoming: 50,
    federator_outgoing: 50,
    ap_incoming: 15,
    ap_publish: 15
  ]

config :mime, :types, %{
  "application/activity+json" => ["activity+json"]
}

# append/override config based on env
import_config "#{config_env()}.exs"


# include config for all used Bonfire extensions
for config <- "bonfire_*.exs" |> Path.expand(__DIR__) |> Path.wildcard() do
  # IO.inspect(include_config: config)
  import_config config
end

import_config "activity_pub.exs"

# import_config "bonfire_boundaries.exs"
# import_config "bonfire_mailer.exs"
# import_config "bonfire_federate_activitypub.exs"
# import_config "bonfire_files.exs"

# import_config "bonfire_me.exs"
# import_config "bonfire_social.exs"
# import_config "bonfire_tag.exs"
# import_config "bonfire_classify.exs"

# # import_config "bonfire_publisher_thesis.exs"
# import_config "bonfire_fail.exs"
# import_config "bonfire_quantify.exs"
# import_config "bonfire_geolocate.exs"
# # import_config "bonfire_valueflows.exs"
# import_config "bonfire_api_graphql.exs"

# import_config "bonfire_search.exs"

# # include common modules
# import_config "bonfire_common.exs"

# # include DB schemas
# import_config "bonfire_data.exs"

# # include hooks (for extensions to hook into each other)
# import_config "bonfire_hooks.exs"

# # include UI settings
# import_config "bonfire_ui.exs"
