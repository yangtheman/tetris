Tetris
======

Simple Self-played Tetris Game

### Introduction

This is a self-playing game of Tetris

### How to run

* Load it up in irb 

```ruby
$ irb
> load 'tetris.rb'
```

* Play the game

```ruby
> t = Tetris.new
> t.play
User picked 6, 7 where last row is 0
User picked 5, 6 where last row is 2
User picked 1, 2 where last row is 0
User picked 6, 7 where last row is 4
User picked 5, 6 where last row is 6
User picked 4, 5 where last row is 8
User picked 8, 9 where last row is 0
User picked 6, 7 where last row is 8
User picked 4, 5 where last row is 10
User picked 4, 5 where last row is 12
User picked 8, 9 where last row is 2
User picked 1, 2 where last row is 2
User picked 8, 9 where last row is 4
User picked 1, 2 where last row is 4
User picked 8, 9 where last row is 6
User picked 8, 9 where last row is 8
User picked 5, 6 where last row is 14
User picked 8, 9 where last row is 10
User picked 2, 3 where last row is 6
User picked 6, 7 where last row is 16
User picked 7, 8 where last row is 18
User picked 8, 9 where last row is 20
GAME OVER!
 => nil 
>
```

### How to test

```ruby
$ rspec ./spec/tetris_spec.rb
```