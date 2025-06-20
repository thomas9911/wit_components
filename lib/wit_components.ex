defmodule WitComponents do
  @moduledoc """
  Documentation for `WitComponents`.
  """

  defmodule Resolve do
    defstruct [:packages, :interfaces, :types, :worlds]
  end

  defmodule Package do
    defstruct [:interfaces, :worlds, :name]
  end

  defmodule World do
    defstruct [:imports, :exports, :name, :package]
  end

  defmodule TypeDef do
    defstruct [:owner, :kind, :name]
  end

  defmodule Interface do
    defstruct [:types, :package, :name, :functions]
  end

  def wit_from_component(wasm_binary) do
    case WitComponents.Native.wit_from_component(wasm_binary) do
      {:error, error} ->
        {:error, error}

      wit ->
        {:ok, rename_structs(wit)}
    end
  end

  def rename_structs(%{__struct__: :Package} = struct) do
    %{struct | __struct__: WitComponents.Package}
  end

  def rename_structs(%{__struct__: :World} = struct) do
    %{struct | __struct__: WitComponents.World}
  end

  def rename_structs(%{__struct__: :TypeDef} = struct) do
    %{struct | __struct__: WitComponents.TypeDef}
  end

  def rename_structs(%{__struct__: :Interface} = struct) do
    %{struct | __struct__: WitComponents.Interface}
  end

  def rename_structs(
        %{packages: packages, interfaces: interfaces, types: types, worlds: worlds} = result
      ) do
    %{
      result
      | packages: Enum.map(packages, &rename_structs/1),
        interfaces: Enum.map(interfaces, &rename_structs/1),
        types: Enum.map(types, &rename_structs/1),
        worlds: Enum.map(worlds, &rename_structs/1),
        __struct__: WitComponents.Resolve
    }
  end

  def rename_structs(struct), do: struct
end
