import gleam/int
import gleam/float
import gleam/string

pub fn pence_to_pounds(pence: Int) -> Float {
  let result = int.to_float(pence)
  |> float.divide(100.0)

  case result {
    Ok(value) -> value
    Error(_err) -> 0.0
  }
}

pub fn pounds_to_string(pounds: Float) -> String {
  let pounds_string = float.to_string(pounds)
  string.concat(["£", pounds_string])
}
