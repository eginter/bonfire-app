defmodule Iconify.Arcticons.Pomotodo do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      aria-hidden="true"
      role="img"
      class={@class}
      viewBox="0 0 48 48"
      aria-hidden="true"
    >
      <path
        fill="none"
        stroke="currentColor"
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M24 2.5a21.515 21.515 0 1 0 18.816 11.11c-11.229 7.287-19.31 19.874-19.31 19.874l-10.8-12.035l2.827-2.676L22.89 24s10.096-8.369 18.492-12.646A21.5 21.5 0 0 0 24 2.5Z"
      />
    </svg>
    """
  end
end
