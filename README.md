jpro
===

[![CI](https://github.com/yammerjp/jpro/actions/workflows/ci.yaml/badge.svg)](https://github.com/yammerjp/jpro/actions/workflows/ci.yaml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

jpro is a JSON processor that can be written in a JavaScript code piece.

## Demo

You can immediately run the following command, if you have Node.js and npm installed

    $ echo '{"name":"bob","like":["sushi","orange"]}' | npx jpro '.like'
    [
     "sushi",
     "orange"
    ]

Or you can install it and run it without `npx`. This will be faster to execute.

    # Install jpro to your computer
    $ npm install -g jpro

    # Run
    $ echo '{"name":"bob","like":["sushi","orange"]}' | npx jpro '.like'
    [
     "sushi",
     "orange"
    ]

## Usage

jpro is a JSON processor that can be written in a JavaScript code piece.
The command line argument code piece is interpreted as follows.

    eval("output = input " + <A CODE PIECE WITH COMMAND LINE ARGUMENT>)

The following variables are available in the code piece.

- input ... JavaScript object input as JSON from STDIN
- output ... JavaScript object output as JSON to STDOUT
- stdin ... String input from STDIN
- stdout ... String output to STDOUT (Preferred over output, if not null or undefined)

## Examples

Examples of execution is shown below.

    $ echo '{"name":"bob","like":["sushi","orange"]}' | npx jpro '.like'
    [
     "sushi",
     "orange"
    ]

    $ echo '{"name":"bob","like":["sushi","orange"]}' | npx jpro '&& Object.keys(input)'
    [
     "name",
     "like"
    ]

    $ echo '{"name":"bob","like":["sushi","orange"]}' | npx jpro '; stdout = input.like.join("&")'
    sushi&orange

    $ echo 'hello, world' | npx jpro ';stdout = stdin.toUpperCase()'
    Warning: failed to parse JSON from STDIN
    HELLO, WORLD

    $ echo 'hello, world' | JPRO_SILENT=true npx jpro ';stdout = stdin.toUpperCase()'
    HELLO, WORLD

## License

[MIT](https://github.com/yammerjp/jpro/master/LICENSE)

## Author

[yammerjp](https://github.com/yammerjp)
