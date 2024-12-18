package main

import (
	"fmt"
	"strconv"
	"strings"

	"github.com/vposloncec/advent-of-code/2024/helpers"
)

const (
	Corrupted = '#'
)

type Distance int

func (d Distance) Value() int {
	return int(d)
}

func (d Distance) String() string {
	return strconv.Itoa(int(d))
}

func Calculate(rawinput string) int {
	// start := helpers.Location{0, 0}
	// stop := helpers.Location{6, 6}
	steps := 12

	input := strings.Split(rawinput, "\n")
	grid := helpers.Grid{MHeight: 7, MWidth: 7}
	grid.M = make([][]rune, grid.MHeight)
	for y := range grid.MHeight {
		for range grid.MWidth {
			grid.M[y] = append(grid.M[y], '.')
		}
	}
	for i := range steps {
		nums := strings.Split(input[i], ",")
		if len(nums) != 2 {
			continue
		}
		first, _ := strconv.Atoi(strings.TrimSpace(nums[0]))
		second, _ := strconv.Atoi(strings.TrimSpace(nums[1]))
		grid.Set(first, second, Corrupted)
	}
	fmt.Println(grid.String())

	runDijkstra(grid, helpers.Location{0, 0})

	return 0
}

func runDijkstra(grid helpers.Grid, location helpers.Location) {

}
