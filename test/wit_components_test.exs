defmodule WitComponentsTest do
  use ExUnit.Case

  :interfaces
  :worlds
  :packages

  test "decode a wasm binary" do
    {:ok, wit} =
      WitComponents.wit_from_component(
        File.read!(
          "/home/thomas/Betty/native-wasm-components/target/wasm32-wasip2/release/expression.wasm"
        )
      )

    assert %WitComponents.Resolve{
             packages: [%WitComponents.Package{} | _],
             interfaces: [%WitComponents.Interface{} | _],
             types: [%WitComponents.TypeDef{} | _],
             worlds: [%WitComponents.World{} | _]
           } = wit
  end

  test "error on random binary" do
    {:error, _} = WitComponents.wit_from_component(<<0, 1, 2, 3>>)
  end
end
