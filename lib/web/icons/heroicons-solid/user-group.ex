defmodule Iconify.HeroiconsSolid.UserGroup do
  use Phoenix.Component
  def render(assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" class={@class} viewBox="0 0 24 24" aria-hidden="true"><path fill="currentColor" d="M13 6a3 3 0 1 1-6 0a3 3 0 0 1 6 0Zm5 2a2 2 0 1 1-4 0a2 2 0 0 1 4 0Zm-4 7a4 4 0 0 0-8 0v3h8v-3ZM6 8a2 2 0 1 1-4 0a2 2 0 0 1 4 0Zm10 10v-3a5.972 5.972 0 0 0-.75-2.906A3.005 3.005 0 0 1 19 15v3h-3ZM4.75 12.094A5.973 5.973 0 0 0 4 15v3H1v-3a3 3 0 0 1 3.75-2.906Z"/></svg>
    """
  end
end
