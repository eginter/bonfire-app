defmodule Iconify.Cil.Recycle do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      aria-hidden="true"
      role="img"
      class={@class}
      viewBox="0 0 512 512"
      aria-hidden="true"
    >
      <path
        fill="currentColor"
        d="M68.328 383.063a31.654 31.654 0 0 1 .207-32.118l50.883-86.406l11.516 50.76l31.207-7.08l-23.884-105.275l-105.274 23.884l7.08 31.207l53.149-12.058l-52.252 88.73a64 64 0 0 0 55.149 96.476h82.435l32-32H96.109a31.655 31.655 0 0 1-27.781-16.12ZM283.379 79.762l53.747 91.268l-49.053-7.653l-4.934 31.617L389.8 211.635l16.64-106.66l-31.617-4.933l-8.873 56.87l-54.996-93.388a64 64 0 0 0-110.3 0l-39.939 67.82l10.407 45.39l57.106-96.972a32 32 0 0 1 55.148 0ZM470.65 334.707l-47.867-81.283l-41.148-6.812l61.441 104.333a32 32 0 0 1-27.576 48.238H304.046l38.359-38.358l-22.627-22.625l-76.332 76.332l76.332 76.333l22.627-22.628l-37.052-37.051H415.5a64 64 0 0 0 55.149-96.476Z"
      />
    </svg>
    """
  end
end
