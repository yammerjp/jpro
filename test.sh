#!/bin/bash -e

OWN_FILE="$0"
J_J="$(dirname "$0")/index.js"
function print_prev_line() {
  head -n "$(( BASH_LINENO - 1 ))" "$OWN_FILE" | tail -1
}

function j-j ()
{
  "$J_J" "$@"
}

echo 'run tests...'

# ==============================

expected='[
 "sushi",
 "orange"
]'
actual="$( \
  echo '{"name":"bob","like":["sushi","orange"]}' | j-j '.like'
)"; print_prev_line
test "$expected" = "$actual"

# ==============================

expected='[
 "name",
 "like"
]'
actual="$( \
  echo '{"name":"bob","like":["sushi","orange"]}' | j-j '&& Object.keys(input)'
)"; print_prev_line
test "$expected" = "$actual"

# ==============================

expected='sushi&orange'
actual="$( \
  echo '{"name":"bob","like":["sushi","orange"]}' | j-j '; stdout = input.like.join("&")'
)"; print_prev_line
test "$expected" = "$actual"

# ==============================

expected='Warning: failed to parse JSON from STDIN
HELLO, WORLD'
actual="$( \
  echo 'hello, world' | j-j ';stdout = stdin.toUpperCase()' 2>&1
)"; print_prev_line
test "$expected" = "$actual"

# ==============================

expected='HELLO, WORLD'
actual="$( \
  echo 'hello, world' | J_J_SILENT=true j-j ';stdout = stdin.toUpperCase()'
)"; print_prev_line
test "$expected" = "$actual"
