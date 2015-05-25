defmodule FetchRescuetime.Mixfile do
  use Mix.Project

  def project do
    [app: :fetch_rescuetime,
     version: "0.0.1",
     elixir: "~> 1.0",
     escript: escript_config,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:timex, "~> 0.13.4"},
      {:httpoison, "~> 0.6"},
      {:poison, "~>1.4"}
    ]
  end

  defp escript_config do
    [ main_module: FetchRescuetime ]
  end

end
