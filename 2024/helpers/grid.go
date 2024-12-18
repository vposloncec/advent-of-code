package helpers

import "strings"

type Grid struct {
	M       [][]rune
	MWidth  int
	MHeight int
}

type LocDir struct {
	Loc Location
	Dir Direction
}

type Location struct {
	X, Y int
}

type Direction Location

var (
	East  = Direction{1, 0}
	West  = Direction{-1, 0}
	North = Direction{0, -1}
	South = Direction{0, 1}
)

func (g *Grid) At(loc Location) rune {
	return g.M[loc.Y][loc.X]
}

func (g *Grid) Set(x, y int, val rune) {
	g.M[y][x] = val
}

func NewGrid(rawinput string) *Grid {
	input := strings.Split(rawinput, "\n")
	var matrix [][]rune
	for _, row := range input {
		matrix = append(matrix, []rune(row))
	}

	return &Grid{M: matrix, MWidth: len(matrix[0]), MHeight: len(matrix)}
}

func NewGridWithFunc(rawinput string, f func(rune) rune) *Grid {
	input := strings.Split(rawinput, "\n")
	matrix := make([][]rune, len(input))
	for y, row := range input {
		for _, char := range row {
			matrix[y] = append(matrix[y], f(char))
		}
	}

	return &Grid{M: matrix, MWidth: len(matrix[0]), MHeight: len(matrix)}
}

func (g *Grid) String() string {
	var res strings.Builder
	for _, row := range g.M {
		for _, char := range row {
			res.WriteRune(char)
		}
		res.WriteRune('\n')
	}
	return res.String()
}

func rotateRight(dir Direction) Direction {
	switch dir {
	case East:
		return South
	case South:
		return West
	case West:
		return North
	case North:
		return East
	}
	return dir
}

func rotateLeft(dir Direction) Direction {
	switch dir {
	case East:
		return North
	case North:
		return West
	case West:
		return South
	case South:
		return East
	default:
		return dir
	}
}

func Move(loc Location, dir Direction) Location {
	return Location{loc.X + dir.X, loc.Y + dir.Y}
}

func (r Grid) inBounds(loc Location) bool {
	return loc.X >= 0 && loc.X < r.MWidth && loc.Y >= 0 && loc.Y < r.MHeight
}
