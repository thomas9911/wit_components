use rustler::{Binary, Error, NifResult};
use rustler::serde::SerdeTerm;
use wit_component::DecodedWasm;
use wit_parser::Resolve;

#[rustler::nif]
fn wit_from_component(wasm_binary: Binary) -> NifResult<SerdeTerm<Resolve>> {
    let data = wit_component::decode(wasm_binary.as_slice()).map_err(|e| Error::Term(Box::new(e.to_string())))?;
    let resolve = match data{
        DecodedWasm::WitPackage(resolve, _) => resolve,
        DecodedWasm::Component(resolve, _) => resolve,
    };

    Ok(SerdeTerm(resolve))

}

rustler::init!("Elixir.WitComponents.Native");
