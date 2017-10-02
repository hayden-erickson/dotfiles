load ../index.sh

cf-login

@test "invoking cf-login with no params should throw error" {
  run cf-login
  [ "$status" -eq 1 ]
}
