package main

import (
	"container/heap"
	"fmt"
	"strings"
)

type Race struct {
	m             [][]rune
	mWidth        int
	mHeight       int
	startLoc      Location
	pathQueue     PriorityQueue
	visited       map[LocDir]int
	bestPathTiles map[Location]struct{}
}

type LocDir struct {
	loc Location
	dir Direction
}

type Location struct {
	x, y int
}

type Direction Location

type Path struct {
	cost    int
	loc     Location
	dir     Direction
	visited map[Location]struct{}
}

func (p Path) Value() int {
	return p.cost
}
func (p Path) String() string {
	return fmt.Sprintf("Cost: %v, Loc: %v, Dir: %v", p.cost, p.loc, p.dir)
}

const (
	Wall  = '#'
	Space = '.'
	Start = 'S'
	End   = 'E'
)

var (
	East  = Direction{1, 0}
	West  = Direction{-1, 0}
	North = Direction{0, -1}
	South = Direction{0, 1}
)

func NewRace(rawinput string) *Race {
	input := strings.Split(rawinput, "\n")
	var startLoc Location
	var matrix [][]rune
	for y, row := range input {
		for x, char := range row {
			if char == Start {
				startLoc = Location{x, y}
			}
		}
		matrix = append(matrix, []rune(row))
	}

	return &Race{m: matrix, startLoc: startLoc, mWidth: len(matrix[0]), mHeight: len(matrix), visited: make(map[LocDir]int)}
}

func (r *Race) String() string {
	var res strings.Builder
	for y, row := range r.m {
		for x, char := range row {
			if _, ok := r.bestPathTiles[Location{x, y}]; ok {
				res.WriteRune('O')
			} else {
				res.WriteRune(char)
			}
		}
		res.WriteRune('\n')
	}
	return res.String()
}

func (r *Race) Calculate() int {
	return r.findPathsToEnd()
}

func (r *Race) TilesOnBestPath() int {
	r.findPathsToEnd()
	bestPathTiles := make(map[Location]struct{})

	for r.pathQueue.Len() > 0 {
		path := heap.Pop(&r.pathQueue).(Path)
		if path.cost > r.visited[LocDir{path.loc, path.dir}] {
			break
		}
		if r.m[path.loc.y][path.loc.x] != End {
			continue
		}
		for location := range path.visited {
			bestPathTiles[location] = struct{}{}
		}
	}
	r.bestPathTiles = bestPathTiles
	// fmt.Println(r.String())
	// fmt.Println(r.pathQueue.String())

	return len(bestPathTiles) + 1
}

// Returns minimal cost
func (r *Race) findPathsToEnd() int {
	heap.Init(&r.pathQueue)
	startVisited := make(map[Location]struct{})
	heap.Push(&r.pathQueue, Path{0, r.startLoc, East, startVisited})
	for r.pathQueue.Len() > 0 {
		currPath := heap.Pop(&r.pathQueue).(Path)
		// fmt.Printf("Current cost: %v, location: %v, dir: %v, value: %v\n", currPath.cost, currPath.loc, currPath.dir, string(r.m[currPath.loc.y][currPath.loc.x]))
		// fmt.Printf("Current heap: %v\n", r.pathQueue)
		if r.isVisited(currPath.loc, currPath.dir) && (r.visited[LocDir{currPath.loc, currPath.dir}] < currPath.cost) {
			continue
		}
		r.visited[LocDir{currPath.loc, currPath.dir}] = currPath.cost
		if r.m[currPath.loc.y][currPath.loc.x] == End {
			// Found the end, push back to stack (needed for part 2) and finish
			// fmt.Println(currPath.cost)
			heap.Push(&r.pathQueue, currPath)
			return currPath.cost
		}

		newPos := move(currPath.loc, currPath.dir)
		if r.isValid(newPos) && !r.isWall(newPos) {

			newPathVisited := visitedWithNewLoc(currPath.visited, newPos)
			heap.Push(&r.pathQueue, Path{currPath.cost + 1, newPos, currPath.dir, newPathVisited})
		}
		heap.Push(&r.pathQueue, Path{currPath.cost + 1000, currPath.loc, rotateRight(currPath.dir), currPath.visited})
		heap.Push(&r.pathQueue, Path{currPath.cost + 1000, currPath.loc, rotateLeft(currPath.dir), currPath.visited})
	}
	return 0
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

func visitedWithNewLoc(visited map[Location]struct{}, loc Location) map[Location]struct{} {
	newVisited := make(map[Location]struct{}, len(visited)+1)
	for key, value := range visited {
		newVisited[key] = value
	}
	newVisited[loc] = struct{}{}
	return newVisited
}

func move(pos Location, dir Direction) Location {
	return Location{pos.x + dir.x, pos.y + dir.y}
}

func (r Race) isValid(loc Location) bool {
	return loc.x >= 0 && loc.x < r.mWidth && loc.y >= 0 && loc.y < r.mHeight
}

func (r Race) isWall(loc Location) bool {
	return r.m[loc.y][loc.x] == Wall
}

func (r Race) isVisited(loc Location, dir Direction) bool {

	_, visited := r.visited[LocDir{loc, dir}]
	return visited
}
