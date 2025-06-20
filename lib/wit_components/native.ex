defmodule WitComponents.Native do
  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :wit_components,
    crate: "witcomponents_native",
    base_url: "https://github.com/thomas9911/wit_components/releases/download/v#{version}",
    version: version

  # When your NIF is loaded, it will override this function.
  def wit_from_component(_wasm_binary), do: :erlang.nif_error(:nif_not_loaded)
end
