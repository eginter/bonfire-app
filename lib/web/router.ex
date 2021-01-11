defmodule Bonfire.Web.Router do
  use Bonfire.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Bonfire.Web.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Bonfire.Web.Plugs.LoadCurrentAccount
    plug Bonfire.Web.Plugs.LoadCurrentUser
  end

  pipeline :guest_only do
    plug Bonfire.Web.Plugs.GuestOnly
  end

  pipeline :bread_pub do
    plug :put_root_layout, {Bonfire.UI.ValueFlows.LayoutView, :root}
  end

  pipeline :website do
    plug :put_root_layout, {Bonfire.Website.LayoutView, :root}
  end


  pipeline :account_required do
    plug Bonfire.Web.Plugs.AccountRequired
  end

  pipeline :user_required do
    plug Bonfire.Web.Plugs.UserRequired
  end

  pipeline :admin_required do
    plug Bonfire.Web.Plugs.AdminRequired
  end

  # pages anyone can view
  scope "/", Bonfire do
    pipe_through :browser

    # a default homepage which you can customise (at path "/")
    # can be replaced with something else (eg. bonfire_website extension or similar), in which case you may want to rename the path (eg. to "/home")
    live "/home", Web.HomeLive

    live "/user/:username", Me.Web.ProfileLive
    live "/user/:username/circles", Me.Web.CirclesLive
    live "/user/:username/posts", Me.Web.PostsLive
    live "/user/:username/posts/:post_id", Me.Web.PostLive

    live "/instance", UI.Social.InstanceLive

    live "/thread", Me.Web.ThreadLive

  end

  # bonfire_website extension - anyone can view
  scope "/", Bonfire.Website do
    pipe_through :browser
    pipe_through :website

    live "/", HomeGuestLive
  end

  # pages only guests can view
  scope "/", Bonfire.Me.Web do
    pipe_through :browser
    pipe_through :guest_only

    resources "/signup", SignupController, only: [:index, :create]
    resources "/confirm-email", ConfirmEmailController, only: [:index, :create, :show]
    resources "/login", LoginController, only: [:index, :create]
    resources "/forgot-password", ForgotPasswordController, only: [:index, :create]
    resources "/reset-password", ResetPasswordController, only: [:show, :update]
  end

  # pages you need an account to view
  scope "/", Bonfire do
    pipe_through :browser
    pipe_through :account_required

    live "/dashboard", Me.Web.LoggedDashboardLive
    live "/fediverse", UI.Social.FediverseLive

    resources "/switch-user", Me.Web.SwitchUserController, only: [:index, :show]
    resources "/create-user", Me.Web.CreateUserController, only: [:index, :create]

    live "/change-password", Me.Web.ChangePasswordLive

    live "/settings", Me.Web.SettingsLive

    resources "/delete", Me.Web.AccountDeleteController, only: [:index, :create]

    resources "/logout", Me.Web.LogoutController, only: [:index, :create]
 end

  # pages you need to view as a user
  scope "/", Bonfire do
    pipe_through :browser
    pipe_through :user_required

    live "/feed", UI.Social.FeedPageLive

    live "/settings", Me.Web.UserSettingsLive

    resources "/delete", Me.Web.UserDeleteController, only: [:index, :create]
  end

  # pages you need to view as a user
  scope "/bread", Bonfire.UI.ValueFlows do
    pipe_through :browser
    pipe_through :user_required
    pipe_through :bread_pub

    live "/", BreadDashboardLive
    live "/milestones", ProcessesLive
    live "/milestone/:milestone_id", ProcessLive
    live "/intent/:intent_id", ProposalLive
    live "/proposal/:proposal_id", ProposalLive
    live "/proposed_intent/:proposed_intent_id", ProposalLive

    live "/map/", MapLive
    live "/map/:id", MapLive
  end

  # pages only admins can view
  scope "/settings" do
    pipe_through :browser
    pipe_through :admin_required
    live "/", InstanceSettingsLive
  end



  # include federation routes
  use ActivityPubWeb.Router

  # include nodeinfo routes
  use NodeinfoWeb.Router

  # include GraphQL API
  use Bonfire.GraphQL.Router

  if Mix.env() in [:dev, :test] do
    scope "/" do
      pipe_through :browser
      if Code.ensure_loaded?(Phoenix.LiveDashboard.Router) do
        import Phoenix.LiveDashboard.Router
        live_dashboard "/dashboard", metrics: Bonfire.Web.Telemetry
      end
      if Code.ensure_loaded?(Bamboo.SentEmailViewerPlug) do
        forward "/emails", Bamboo.SentEmailViewerPlug
      end
    end
  end
end
