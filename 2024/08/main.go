package main

import "strings"

type Frequency string

type Location struct {
	x, y int
}

type AntiNodeFinder struct {
	mapSize       Location
	antiNodeMap   map[Location]struct{}
	towerLocation map[Frequency][]Location
}

func NewAntiNodeFinder(input string) *AntiNodeFinder {
	towerLocation := make(map[Frequency][]Location)
	antiNodeMap := make(map[Location]struct{})

	var maxX int
	for y, line := range strings.Split(input, "\n") {
		if y == 0 {
			maxX = len(line) - 1
		}

		for x, char := range line {
			if char == '.' {
				continue
			}
			towerLocation[Frequency(char)] = append(towerLocation[Frequency(char)], Location{x, y})
		}
	}

	return &AntiNodeFinder{towerLocation: towerLocation, antiNodeMap: antiNodeMap, mapSize: Location{maxX, strings.Count(input, "\n")}}
}

func (f AntiNodeFinder) FindAntiNodes() int {
	return f.calculateAntiNodeNumber(findAntiNodeLocations)
}

func (f AntiNodeFinder) FindMoreAntiNodes() int {
	return f.calculateAntiNodeNumber(findMoreAntiNodeLocations)
}

// Takes in a function that return locations of antiNodes for two tower locations
func (f AntiNodeFinder) calculateAntiNodeNumber(antiNodeFinder func(Location, Location, Location) []Location) int {
	for _, locations := range f.towerLocation {
		if len(locations) > 1 {
			for i := 0; i < len(locations); i++ {
				for j := i + 1; j < len(locations); j++ {
					antiNodes := antiNodeFinder(locations[i], locations[j], f.mapSize)
					for _, node := range antiNodes {
						f.antiNodeMap[node] = struct{}{}
					}
				}
			}
		}
	}

	return len(f.antiNodeMap)
}

func findMoreAntiNodeLocations(loc1, loc2, mapSize Location) (res []Location) {
	diffx := loc1.x - loc2.x
	diffy := loc1.y - loc2.y
	res = append(res, Location{loc1.x, loc1.y})
	for x, y := loc1.x, loc1.y; ; {
		x += diffx
		y += diffy
		node := Location{x, y}
		if node.x >= 0 && node.y >= 0 && node.x <= mapSize.x && node.y <= mapSize.y {
			res = append(res, node)
		} else {
			break
		}
	}
	for x, y := loc1.x, loc1.y; ; {
		x -= diffx
		y -= diffy
		node := Location{x, y}
		if node.x >= 0 && node.y >= 0 && node.x <= mapSize.x && node.y <= mapSize.y {
			res = append(res, node)
		} else {
			break
		}
	}
	return res
}

func findAntiNodeLocations(loc1, loc2, maxSize Location) (res []Location) {
	diffx := loc1.x - loc2.x
	diffy := loc1.y - loc2.y
	node1 := Location{loc1.x + diffx, loc1.y + diffy}
	if node1 == loc2 {
		node1 = Location{loc1.x - diffx, loc1.y - diffy}
	}
	node2 := Location{loc2.x + diffx, loc2.y + diffy}
	if node2 == loc1 {
		node2 = Location{loc2.x - diffx, loc2.y - diffy}
	}
	for _, node := range []Location{node1, node2} {
		if node.x >= 0 && node.y >= 0 && node.x <= maxSize.x && node.y <= maxSize.y {
			res = append(res, node)
		}
	}

	return res
}
