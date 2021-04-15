# Fancy Triples

## Goals

Learn to use:

* property animation
* custom views
* drawing
* gestures
* tab bar view controllers
* user defaults
* dynamic animations

## Progress

- [ ] Task 1: Create a Tile Model

Create a data tructure like this:

```Swift
struct Tile: Identifiable {
    var val : Int
    public var id  = UUID()
    var row: Int 
    var col: Int  
}
```

`val` represents the value to be shown on the board, `id` is an unique id for this tile. Also include `row` and `col` to represent the location of this Tile on the board. Then, the `board` triples class will change from [[Int]] to [[Tile]]. 

- [ ] Task 2: Change View to use TileView

- [ ] Task 3: Animation

- [ ] Task 4: End of Game

When will the game end?

1. When there is no any empty tile or possible moves of the tiles in the board.
You should handle the situation where some of the directions are not executable where some other directions are executable. In this situation, clicking the un-executable direction button will do nothing. Only when ALL 4 directions are not executable, the game is ended. 

2. When we click the `New Game` button.
Every time we click the `New Game` button, the current game will end.

What will happen after the game ends?

A window should pop up to show the final score of current play. You can use `ZStack` to implement this view. By clicking the "Close" button should start a new game. Every time a game ends, the score should be recorded, this will be discussed in later task.

- [ ] Task 5: Gestures

Add up, down, left, and right drag gestures to the board. Each direction gesture should work exactly the same as cliking the direction buttom.  

- [ ] Task 6: TabView

- [ ] Task 7: Implement the *HighScores* Page

- [ ] Task 8: Implement the *About* Page with Fancy  Animation

- [ ] Task 9: Portrait vs. Landscape
