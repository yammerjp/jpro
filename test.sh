#!/bin/bash -e

OWN_FILE="$0"
JPRO="$(dirname "$0")/index.js"
function print_prev_line() {
  head -n "$(( BASH_LINENO - 1 ))" "$OWN_FILE" | tail -1
}

function jpro ()
{
  "$JPRO" "$@"
}

echo 'run tests...'

# ==============================

expected='[
 "sushi",
 "orange"
]'
actual="$( \
  echo '{"name":"bob","like":["sushi","orange"]}' | jpro '.like'
)"; print_prev_line
test "$expected" = "$actual"

# ==============================

expected='[
 "name",
 "like"
]'
actual="$( \
  echo '{"name":"bob","like":["sushi","orange"]}' | jpro '&& Object.keys(input)'
)"; print_prev_line
test "$expected" = "$actual"

# ==============================

expected='sushi&orange'
actual="$( \
  echo '{"name":"bob","like":["sushi","orange"]}' | jpro '; stdout = input.like.join("&")'
)"; print_prev_line
test "$expected" = "$actual"

# ==============================

expected='Warning: failed to parse JSON from STDIN
HELLO, WORLD'
actual="$( \
  echo 'hello, world' | jpro ';stdout = stdin.toUpperCase()' 2>&1
)"; print_prev_line
test "$expected" = "$actual"

# ==============================

expected='HELLO, WORLD'
actual="$( \
  echo 'hello, world' | JPRO_SILENT=true jpro ';stdout = stdin.toUpperCase()'
)"; print_prev_line
test "$expected" = "$actual"
