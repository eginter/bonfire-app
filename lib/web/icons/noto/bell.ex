defmodule Iconify.Noto.Bell do
  use Phoenix.Component
  def render(assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" class={@class} viewBox="0 0 128 128" aria-hidden="true"><path fill="#E2A610" d="M53.32 18.8c0-7.09 5.77-12.86 12.86-12.86s12.86 5.77 12.86 12.86s-5.77 12.86-12.86 12.86S53.32 25.9 53.32 18.8zm7.48 0c0 2.97 2.41 5.38 5.38 5.38c2.97 0 5.38-2.41 5.38-5.38c0-2.97-2.41-5.38-5.38-5.38c-2.97 0-5.38 2.42-5.38 5.38z"/><path fill="#9E740B" d="M77.24 12.28s.57 2.27-2.06 3.51c-2.63 1.23-4.37.32-4.37.32c.47.8.75 1.71.75 2.7c0 2.97-2.41 5.38-5.38 5.38c-2.97 0-5.38-2.41-5.38-5.38c0-.3.07-1.43.55-2.37c-4.46 2.12-7.85.31-7.85.31c-.11.67-.18 1.36-.18 2.06c0 7.09 5.77 12.86 12.86 12.86S79.04 25.9 79.04 18.8c0-2.38-.66-4.61-1.8-6.52z"/><path fill="#FFCA28" d="M10.46 97.8c6.77-6.65 10.99-8.89 12.71-18.53c1.72-9.64.34-29.95 7.92-43.25C38.01 23.84 50.71 18.8 63.1 18.8c.3 0 .6.02.9.02c.3-.01.6-.02.9-.02c12.39 0 25.09 5.04 32.01 17.21c7.57 13.31 6.2 33.62 7.92 43.25c1.72 9.64 5.94 11.88 12.71 18.53c2.92 2.87 6.45 7.44 6.46 10.38c.01 2.94-1.49 4.01-5.06 5.51c-10.1 4.25-23.6 8.37-54.94 8.37s-44.84-4.12-54.94-8.37c-3.57-1.5-5.07-2.56-5.06-5.51c.01-2.93 3.54-7.5 6.46-10.37z"/><path fill="#4E342E" d="M113.7 108.38c0-4.43-22.25-8.02-49.7-8.02s-49.7 3.59-49.7 8.02s22.25 9.72 49.7 9.72s49.7-5.29 49.7-9.72z"/><path fill="#E2A610" d="M93.84 44.79c.37 1.41.68 2.82.93 4.2c1.27 7.06 1.04 14.3 1.61 21.45c.77 9.57 2.47 14.61 6.34 19.11c.51.59-.01 1.5-.78 1.38c-5.17-.79-9.32-1.58-14.05-4.7c-7.06-4.65-8.8-13.4-8.85-21.26c-.08-11.7.14-23.03-.79-27.33c-1.29-5.99-2.49-9.18-4.45-12.09c-2.99-4.44 8.62 1.72 10.44 3.09c5.07 3.83 7.98 9.99 9.6 16.15z"/><path fill="#FFF59D" d="M30.89 60.32c-.12-7.58-.06-15.42 2.96-22.38c1.81-4.16 4.88-7.91 8.8-10.24c3.08-1.83 9.34-3.85 11.59.3c.45.83.63 1.8.66 2.75c.08 3.31-1.64 6.37-3.31 9.23c-4.94 8.48-6.91 17.75-9.52 27.15c-1.07 3.88-2.43 7.75-4.76 11.03c-1.6 2.25-10.51 10.25-8.47 3.02C30.8 74.19 31 67.6 30.89 60.32z"/><path fill="#E2A610" d="M73.09 106.82c-.01-1.72-.94-2.71-3.08-3.45c-4.44-1.53-10-1.25-13.24.49c-3.4 1.82-1.04 11.91 7.23 11.91s9.1-7.64 9.09-8.95z"/><path fill="#FFF59D" d="M33.25 91.79c-8.78 1.54-15.14 4.87-17.89 7.57c-2.18 2.13-2.18 3.81 1.66 2.06c2.89-1.32 12.15-4 20.26-4.81c13.93-1.4 22.53-1.43 23.96-1.4c3.35.07 3.63-2.51-3.14-3.42c-6.77-.9-16.07-1.53-24.85 0zm27.21 22.03c1.16.8 2.7 1.19 4 .65c1.3-.54 2.14-2.19 1.5-3.44c-.25-.49-.68-.86-1.11-1.2c-1.19-.93-2.51-1.69-3.91-2.25c-.55-.22-1.13-.42-1.73-.38c-.59.03-1.21.34-1.44.89c-.99 2.25.99 4.57 2.69 5.73z"/></svg>
    """
  end
end
