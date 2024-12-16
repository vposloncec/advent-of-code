package main

import (
	"fmt"
	"strings"

	"errors"
)

const (
	Wall  = '#'
	Box   = 'O'
	Space = '.'
	Robot = '@'
	BBoxL = '['
	BBoxR = ']'
)

type Location struct {
	x, y int
}
type Direction Location

type WarehouseWoes struct {
	w             [][]rune
	moves         string
	robotLocation Location
	wWidth        int
	wHeight       int
}

func NewWarehouseWoes(rawinput string) *WarehouseWoes {
	input := strings.Split(rawinput, "\n\n")
	var robLoc Location
	var matrix [][]rune
	for y, row := range strings.Split(input[0], "\n") {
		i := strings.Index(row, string(Robot))
		if i != -1 {
			robLoc = Location{i, y}
		}

		matrix = append(matrix, []rune(row))
	}

	moves := strings.ReplaceAll(input[1], "\n", "")

	return &WarehouseWoes{w: matrix, moves: moves, robotLocation: robLoc, wWidth: len(matrix[0]), wHeight: len(matrix)}
}

func (w *WarehouseWoes) String() string {
	var res strings.Builder
	for _, row := range w.w {
		res.WriteString(string(row) + "\n")
	}
	return res.String()
}

func (w *WarehouseWoes) Calculate() int {
	// fmt.Println(w.moves)
	for _, move := range w.moves {
		// fmt.Println(w.String())
		// fmt.Printf("Move %v: %v, position: %v, %v\n", i, string(move), w.robotLocation.x, w.robotLocation.y)
		newPos := newPosition(w.robotLocation, move)
		if w.w[newPos.y][newPos.x] == Wall {
			continue
		} else if w.w[newPos.y][newPos.x] == Box {
			if err := w.moveBoxes(newPos, move); err != nil {
				continue
			}
			w.setRobot(newPos)
		} else if w.w[newPos.y][newPos.x] == Space {
			w.setRobot(newPos)
		}
	}

	// fmt.Println(w.String())
	return w.sumBoxes()
}

func (w *WarehouseWoes) CalculateWide() int {
	w.enlarge()
	// fmt.Println(w.moves)
	fmt.Println(w.String())
	for i, move := range w.moves {
		fmt.Println(w.String())
		fmt.Printf("Move %v: %v, position: %v, %v\n", i, string(move), w.robotLocation.x, w.robotLocation.y)
		newPos := newPosition(w.robotLocation, move)
		newVal := w.w[newPos.y][newPos.x]
		if newVal == Wall {
			continue
		} else if newVal == BBoxL || newVal == BBoxR {
			if err := w.moveWideBoxes(newPos, move); err != nil {
				fmt.Println("Error")
				fmt.Println(err)
				continue
			}
			w.setRobot(newPos)
		} else if w.w[newPos.y][newPos.x] == Space {
			w.setRobot(newPos)
		}
	}

	fmt.Println(w.String())
	return w.sumBoxes()

}

func (w *WarehouseWoes) moveWideBoxes(position Location, move rune) error {
	fmt.Println(string(move))
	fmt.Printf("Position: %v, %v\n", position.x, position.y)
	if move == '>' {
		for i := position.x; i < w.wWidth; i++ {
			if w.w[position.y][i] == Wall {
				fmt.Printf("Hit wall at %v, %v\n", i, position.y)
				return errors.New("Hit wall")
			} else if w.w[position.y][i] == BBoxL || w.w[position.y][i] == BBoxR {
				continue
			} else if w.w[position.y][i] == Space {
				w.shiftBoxes(position, i, Direction{1, 0})
				return nil
			}
		}
	} else if move == '<' {
		for i := position.x; i >= 0; i-- {
			if w.w[position.y][i] == Wall {
				return errors.New("Hit wall")
			} else if w.w[position.y][i] == BBoxL || w.w[position.y][i] == BBoxR {
				continue
			} else if w.w[position.y][i] == Space {
				w.shiftBoxes(position, i, Direction{-1, 0})
				return nil
			}
		}
	} else if move == 'v' {
		return w.shiftDown(position)
	} else if move == '^' {
		return w.shiftUp(position)
	}
	return errors.New("We shouldn't get here")
}

func (w *WarehouseWoes) shiftBoxes(position Location, max int, direction Direction) {
	fmt.Printf("Before: %v\n", string(w.w[position.y]))
	switch direction {
	case Direction{1, 0}:
		// Untouched part of the row + additional space + shifted part (we exclude one element at position max) + rest
		w.w[position.y] = []rune(string(w.w[position.y][:position.x]) +
			string('.') +
			string(w.w[position.y][position.x:max]) + string(w.w[position.y][max+1:]))
	case Direction{-1, 0}:
		w.w[position.y] = []rune(string(w.w[position.y][:max]) +
			string(w.w[position.y][max+1:position.x+1]) +
			string('.') +
			string(w.w[position.y][position.x+1:]))
	}
	fmt.Printf("After:  %v\n", string(w.w[position.y]))
}
func (w *WarehouseWoes) shiftUp(position Location) (err error) {
	defer func() {
		if err != nil {
			fmt.Println("GOT AN ERROR")
			fmt.Println(err)
			return
		}
		value := w.w[position.y][position.x]
		w.w[position.y-1][position.x] = value
		w.w[position.y][position.x] = Space
		fmt.Printf("Shifted %v to %v, %v\n", string(value), position.x, position.y-1)
		if value == BBoxL {
			w.w[position.y-1][position.x+1] = BBoxR
			w.w[position.y][position.x+1] = Space
			fmt.Printf("Shifted %v to %v, %v (Alongside)\n", string(value), position.x+1, position.y-1)
		} else if value == BBoxR {
			w.w[position.y-1][position.x-1] = BBoxL
			w.w[position.y][position.x-1] = Space
			fmt.Printf("Shifted %v to %v, %v (Alongside)\n", string(value), position.x+1, position.y-1)
		}
	}()

	value := w.w[position.y][position.x]
	valueAbove := w.w[position.y-1][position.x]
	valueAboveRight := w.w[position.y-1][position.x+1]
	valueAboveLeft := w.w[position.y-1][position.x-1]
	if valueAbove == Wall {
		return errors.New("Hit wall")
	} else if valueAbove == BBoxL || valueAbove == BBoxR {
		e := w.shiftUp(Location{position.x, position.y - 1})
		if e != nil {
			err = e
		}
	}
	if value == BBoxL && (valueAboveRight == BBoxR || valueAboveRight == BBoxL) {
		e := w.shiftUp(Location{position.x + 1, position.y - 1})
		if e != nil {
			err = e
		}
	}
	if value == BBoxR && (valueAboveLeft == BBoxR || valueAboveLeft == BBoxL) {
		e := w.shiftUp(Location{position.x - 1, position.y - 1})
		if e != nil {
			err = e
		}
	}
	return err
}

func (w *WarehouseWoes) shiftDown(position Location) (err error) {
	defer func() {
		if err != nil {
			fmt.Println("GOT AN ERROR")
			fmt.Println(err)
			return
		}
		value := w.w[position.y][position.x]
		w.w[position.y+1][position.x] = value
		w.w[position.y][position.x] = Space
		if value == BBoxL {
			w.w[position.y+1][position.x+1] = BBoxR
			w.w[position.y][position.x+1] = Space
		} else if value == BBoxR {
			w.w[position.y+1][position.x-1] = BBoxL
			w.w[position.y][position.x-1] = Space
		}
	}()

	value := w.w[position.y][position.x]
	valueBelow := w.w[position.y+1][position.x]
	valueBelowR := w.w[position.y+1][position.x+1]
	valueBelowL := w.w[position.y+1][position.x-1]
	if valueBelow == Wall {
		return errors.New("Hit wall")
	} else if valueBelow == BBoxL || valueBelow == BBoxR {
		e := w.shiftDown(Location{position.x, position.y + 1})
		if e != nil {
			err = e
		}
	}
	if value == BBoxL && (valueBelowR == BBoxR || valueBelowR == BBoxL) {
		e := w.shiftDown(Location{position.x + 1, position.y + 1})
		if e != nil {
			err = e
		}
	}
	if value == BBoxR && (valueBelowL == BBoxR || valueBelowL == BBoxL) {
		e := w.shiftDown(Location{position.x - 1, position.y + 1})
		if e != nil {
			err = e
		}
	}
	return err
}

func (w *WarehouseWoes) sumBoxes() (sum int) {
	for y, row := range w.w {
		for x, c := range row {
			if c == Box {
				sum += (y * 100) + x
			}
		}
	}
	return sum
}

func (w *WarehouseWoes) enlarge() {
	neww := make([][]rune, w.wHeight)
	for y, row := range w.w {
		for _, c := range row {
			if c == Box {
				neww[y] = append(neww[y], []rune("[]")...)
			} else if c == Robot {
				neww[y] = append(neww[y], []rune("@.")...)
				w.robotLocation = Location{len(neww[y]) - 2, y}
			} else if c == Wall {
				neww[y] = append(neww[y], []rune("##")...)
			} else if c == Space {
				neww[y] = append(neww[y], []rune("..")...)
			}
		}
	}
	w.wHeight = len(neww)
	w.wWidth = len(neww[0])
	w.w = neww
}

func (w *WarehouseWoes) setRobot(pos Location) {
	w.w[w.robotLocation.y][w.robotLocation.x] = Space
	w.robotLocation = pos
	w.w[pos.y][pos.x] = Robot
}

func (w *WarehouseWoes) moveBoxes(position Location, move rune) error {
	if move == '>' {
		for i := position.x; i < w.wWidth; i++ {
			if w.w[position.y][i] == Wall {
				return errors.New("Hit wall")
			} else if w.w[position.y][i] == Box {
				continue
			} else if w.w[position.y][i] == Space {
				w.shiftBoxes(position, i, Direction{1, 0})
				return nil
			}
		}
		return errors.New("We shouldn't get here")
	} else if move == '<' {
		for i := position.x; i >= 0; i-- {
			if w.w[position.y][i] == Wall {
				return errors.New("Hit wall")
			} else if w.w[position.y][i] == Box {
				continue
			} else if w.w[position.y][i] == Space {
				w.shiftBoxes(position, i, Direction{-1, 0})
				return nil
			}
		}
		return errors.New("We shouldn't get here")
	} else if move == 'v' {
		for i := position.y; i < w.wHeight; i++ {
			if w.w[i][position.x] == Wall {
				return errors.New("Hit wall")
			} else if w.w[i][position.x] == Box {
				continue
			} else if w.w[i][position.x] == Space {
				w.w[i][position.x] = Box
				w.w[position.y][position.x] = Space
				return nil
			}
		}
		return errors.New("We shouldn't get here")
	} else if move == '^' {
		for i := position.y; i >= 0; i-- {
			if w.w[i][position.x] == Wall {
				return errors.New("Hit wall")
			} else if w.w[i][position.x] == Box {
				continue
			} else if w.w[i][position.x] == Space {
				w.w[i][position.x] = Box
				w.w[position.y][position.x] = Space
				return nil
			}
		}
		return errors.New("We shouldn't get here")
	}
	return errors.New("We shouldn't get here")
}

func newPosition(pos Location, move rune) Location {
	switch move {
	case '>':
		pos.x++
	case '<':
		pos.x--
	case 'v':
		pos.y++
	case '^':
		pos.y--
	}
	return pos
}

func swap(s string, i, j int) string {
	r := []rune(s)
	r[i], r[j] = r[j], r[i]
	return string(r)
}
