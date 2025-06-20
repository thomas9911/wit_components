defmodule WitComponents.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :wit_components,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp package do
    [
      files: [
        "lib",
        "native/witcomponents_native/.cargo",
        "native/witcomponents_native/src",
        "native/witcomponents_native/Cargo*",
        "checksum-*.exs",
        "mix.exs"
      ],
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler_precompiled, "~> 0.8.2"},
      {:rustler, "~> 0.36.0", optional: true}
    ]
  end

  defp aliases do
    [
      "print-versions": ["rustler_precompiled.download WitComponents.Native --all --print"]
    ]
  end
end
