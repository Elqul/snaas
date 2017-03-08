port module Ask exposing (ask, confirm)

port ask : String -> Cmd msg

port confirm : (String -> msg) -> Sub msg
