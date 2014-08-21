# Dependencies

Install Common LISP. On OS X using homebrew:

    $ brew install clisp

# Run

Change to the folder and start the game by calling

    $ clisp -i game-of-life.lisp

You can now use the following commands:

    > (print-world) ; show the current status of the world
    > (spawn-random-cell) ; spawn a random cell anywhere
    > (spawn-cell-at 2 4) ; spawns a living cell at x: 2, y: 4
    > (next-generation) ; proceed one generation (calls `print-world`)

Typical usage involves spawning some cells manually at desired locations and call `next-generation` a few times.

