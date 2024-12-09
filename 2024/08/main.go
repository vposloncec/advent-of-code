package main

import "strings"

type Frequency string

type Location struct {
	x, y int
}

func FindAntiNodes(input string) int {
	towerLocation := make(map[Frequency][]Location)
	antiNodeMap := make(map[Location]struct{})

	maxY := strings.Count(input, "\n")
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
	for _, locations := range towerLocation {
		if len(locations) > 1 {
			for i := 0; i < len(locations); i++ {
				for j := i + 1; j < len(locations); j++ {
					antiNodes := findAntiNodeLocations(locations[i], locations[j])
					for _, node := range antiNodes {
						if node.x >= 0 && node.y >= 0 && node.x <= maxX && node.y <= maxY {
							antiNodeMap[node] = struct{}{}
						}
					}
				}
			}
		}
	}
	return len(antiNodeMap)
}

func FindMoreAntiNodes(input string) int {
	towerLocation := make(map[Frequency][]Location)
	antiNodeMap := make(map[Location]struct{})

	maxY := strings.Count(input, "\n")
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
	for _, locations := range towerLocation {
		if len(locations) > 1 {
			for i := 0; i < len(locations); i++ {
				for j := i + 1; j < len(locations); j++ {
					antiNodes := findMoreAntiNodeLocations(locations[i], locations[j], maxX, maxY)
					for _, node := range antiNodes {
						antiNodeMap[node] = struct{}{}
					}
				}
			}
		}
	}
	return len(antiNodeMap)
}

func findMoreAntiNodeLocations(loc1, loc2 Location, maxX, maxY int) (res []Location) {
	diffx := loc1.x - loc2.x
	diffy := loc1.y - loc2.y
	res = append(res, Location{loc1.x, loc1.y})
	for x, y := loc1.x, loc1.y; ; {
		x += diffx
		y += diffy
		node := Location{x, y}
		if node.x >= 0 && node.y >= 0 && node.x <= maxX && node.y <= maxY {
			res = append(res, node)
		} else {
			break
		}
	}
	for x, y := loc1.x, loc1.y; ; {
		x -= diffx
		y -= diffy
		node := Location{x, y}
		if node.x >= 0 && node.y >= 0 && node.x <= maxX && node.y <= maxY {
			res = append(res, node)
		} else {
			break
		}
	}
	return res
}

func findAntiNodeLocations(loc1, loc2 Location) []Location {
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
	return []Location{node1, node2}
}
