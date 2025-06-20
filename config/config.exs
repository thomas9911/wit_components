import Config

if Mix.env() in [:test, :dev] do
  config :rustler_precompiled, :force_build, wit_components: true
end
