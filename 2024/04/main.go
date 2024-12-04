package main

import (
	"strings"
)

type Shirt struct {
	Matrix  [][]rune
	visited [][]bool
	result  int
}

func NewShirt(input string) Shirt {
	lines := strings.Split(input, "\n")
	lineLength := len(lines[0])
	matrix := make([][]rune, len(lines))
	for i, line := range lines {
		matrix[i] = []rune(line)
	}
	return Shirt{Matrix: addPadding(matrix, '.'), visited: make([][]bool, lineLength)}
}

func (s Shirt) String() (res string) {
	for _, line := range s.Matrix {
		res += string(line)
		res += "\n"
	}
	return strings.TrimSuffix(res, "\n")
}

func (s Shirt) search() int {

	for i, line := range s.Matrix {
		for j, char := range line {
			if char == 'X' {
				s.searchPos(i, j, "")
			}
		}
	}
	return s.result
}

func (s Shirt) searchPos(x, y int, current string) {
	if !isUsable(s.Matrix[x][y]) {
		return
	}

	if s.Matrix[x][y] == 'S' && current == "XMA" {
		s.result++
		return
	}
	if s.Matrix[x][x] == 'X' {

	}

}

func isUsable(char rune) bool {
	return char == 'X' || char == 'M' || char == 'A' || char == 'S'
}

func addPadding(matrix [][]rune, padding rune) [][]rune {
	rows := len(matrix)
	if rows == 0 {
		return matrix
	}
	cols := len(matrix[0])

	newMatrix := make([][]rune, rows+2)
	for i := range newMatrix {
		newMatrix[i] = make([]rune, cols+2)
		for j := range newMatrix[i] {
			if i == 0 || i == rows+1 || j == 0 || j == cols+1 {
				newMatrix[i][j] = padding
			} else {
				newMatrix[i][j] = matrix[i-1][j-1]
			}
		}
	}
	return newMatrix
}

func prettify(input string) (res string) {
	for _, line := range strings.Split(input, "\n") {
		for _, char := range line {
			if char != 'X' && char != 'M' {
				res += "."
			} else {
				res += string(char)
			}
		}
		res += "\n"
	}
	return strings.TrimSuffix(res, "\n")
}
