defmodule CallsForService.Mixfile do
  use Mix.Project

  def project do
    [app: :cfs,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :timex, :ex_aws, :hackney, :poison, :cron],
     mod: {CallsForService, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:my_app, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:floki, "~> 0.14.0"},
      {:poison, "~> 2.0"},
      {:timex, "~> 3.1.13"},
      {:ex_aws, "~> 1.1"},
      {:hackney, "~> 1.6"},
      {:cron, in_umbrella: true}
    ]
  end
end
