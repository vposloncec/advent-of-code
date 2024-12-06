package main

import (
	"fmt"
	"strings"
)

type Lab struct {
	labmap              [][]rune
	guardLocation       Location
	guardStartLocation  Location
	guardDirection      Direction
	guardStartDirection Direction
	possibleNewObstacle map[Location]struct{}
	visited             [][][]Direction
	result              int
}

func NewLab(input string) Lab {
	lines := strings.Split(input, "\n")
	lineLength := len(lines[0])
	labmap := make([][]rune, len(lines))
	var guardLocation Location
	var guardStartLocation Location
	var guardStartDirection Direction
	var guardDirection Direction

	for y, line := range lines {
		for x, char := range line {
			labmap[y] = append(labmap[y], char)
			if dir, ok := runeToDirection(char); ok {
				guardLocation = Location{x, y}
				guardStartLocation = Location{x, y}
				guardDirection = *dir
				guardStartDirection = *dir
			}
		}
	}

	visited := make([][][]Direction, len(lines))
	for i := range visited {
		visited[i] = make([][]Direction, lineLength)
	}

	return Lab{labmap: labmap,
		visited:             visited,
		guardLocation:       guardLocation,
		guardStartLocation:  guardStartLocation,
		guardDirection:      guardDirection,
		guardStartDirection: guardStartDirection,
		possibleNewObstacle: make(map[Location]struct{}),
	}
}

func (lab Lab) String() (res string) {
	res += "\n"
	for i, line := range lab.labmap {
		for j, char := range line {
			if i == lab.guardLocation.y && j == lab.guardLocation.x {
				res += "G"
			} else {
				res += string(char)
			}
		}
		res += "\n"
	}
	return res
}

func (lab Lab) ObsticleLoopCount() {

}

// Place a new obstacle at the given location and check if loop will be created
func (lab Lab) CalculateWithObstacle() int {
	lab.guardWalkObstacle()
	return len(lab.possibleNewObstacle)
}

func (lab Lab) CalculateVisited() int {
	lab.guardWalk()
	return lab.countVisited()
}

// # is obstacle that was there before, 0 is obstacle we added
func (lab Lab) isObstacle(l Location) bool {
	return lab.labmap[l.y][l.x] == '#' || lab.labmap[l.y][l.x] == '0'
}

// Check if the location was already accesed from the same direction, if it was, we have a loop
func (lab Lab) isLoop(location Location, direction Direction) bool {
	for _, dir := range lab.visited[location.y][location.x] {
		if dir == direction {
			return true
		}
	}
	return false
}

func (lab Lab) isOutOfBounds(l Location) bool {
	if l.x < 0 || l.y < 0 || l.x >= len(lab.labmap[0]) || l.y >= len(lab.labmap) {
		return true
	}
	return false
}

// Returns true if it found a loop in guard walk, returns false otherwise
func (l *Lab) guardWalk() bool {
	for {
		newLocation := Location{l.guardLocation.x + l.guardDirection.x, l.guardLocation.y + l.guardDirection.y}
		if l.isOutOfBounds(newLocation) {
			l.visited[l.guardLocation.y][l.guardLocation.x] = append(l.visited[l.guardLocation.y][l.guardLocation.x], l.guardDirection)
			break
		} else if l.isLoop(newLocation, l.guardDirection) {
			return true
		} else if l.isObstacle(newLocation) {
			l.guardDirection = l.guardDirection.rotateRight()
		} else {
			l.visited[l.guardLocation.y][l.guardLocation.x] = append(l.visited[l.guardLocation.y][l.guardLocation.x], l.guardDirection)
			l.guardLocation = newLocation
		}

	}
	return false
}

func (l *Lab) guardWalkObstacle() {
	for i := 0; ; i++ {
		newLocation := Location{l.guardLocation.x + l.guardDirection.x, l.guardLocation.y + l.guardDirection.y}
		if l.isOutOfBounds(newLocation) {
			l.visited[l.guardLocation.y][l.guardLocation.x] = append(l.visited[l.guardLocation.y][l.guardLocation.x], l.guardDirection)
			break
		} else if l.isObstacle(newLocation) {
			l.guardDirection = l.guardDirection.rotateRight()
		} else {
			if newLocation != l.guardStartLocation {
				// Set an obstacle at the new Location and go for a new walk
				newLab := l.newLabWithObstacle(newLocation)
				if loop := newLab.guardWalk(); loop {
					l.possibleNewObstacle[newLocation] = struct{}{}
					fmt.Println("Possible new obstacle", newLocation.x, newLocation.y)
				}
			}

			l.visited[l.guardLocation.y][l.guardLocation.x] = append(l.visited[l.guardLocation.y][l.guardLocation.x], l.guardDirection)
			l.guardLocation = newLocation
		}
	}
}

func (lab Lab) newLabWithObstacle(obstacleLocation Location) Lab {
	newLab := Lab{labmap: make([][]rune, len(lab.labmap)),
		visited:             make([][][]Direction, len(lab.visited)),
		guardLocation:       lab.guardStartLocation,
		guardDirection:      lab.guardStartDirection,
		possibleNewObstacle: make(map[Location]struct{}),
	}
	for i, line := range lab.labmap {
		newLab.labmap[i] = make([]rune, len(line))
		copy(newLab.labmap[i], line)
	}
	for i, line := range lab.visited {
		newLab.visited[i] = make([][]Direction, len(line))
	}
	newLab.labmap[obstacleLocation.y][obstacleLocation.x] = '0'

	return newLab
}

func (l Lab) countVisited() (res int) {
	for _, line := range l.visited {
		for _, visited := range line {
			if len(visited) > 0 {
				res++
			}
		}
	}
	return res
}

type Direction struct {
	x, y int
}

type Location struct {
	x, y int
}

func runeToDirection(r rune) (dir *Direction, ok bool) {
	switch r {
	case '^':
		return &Direction{0, -1}, true
	case '>':
		return &Direction{1, 0}, true
	case 'v':
		return &Direction{0, 1}, true
	case '<':
		return &Direction{-1, 0}, true
	}
	return nil, false
}

func (d Direction) rotateRight() Direction {
	d.x, d.y = -d.y, d.x
	return d
}
