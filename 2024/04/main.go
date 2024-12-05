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

func (s Shirt) Search() int {
	for x, line := range s.Matrix {
		for y, char := range line {
			if char == 'X' {
				s.searchAllDirections(x, y, char)
			}
		}
	}
	return s.result
}

func (s Shirt) SearchX() int {
	for x, line := range s.Matrix {
		for y, char := range line {
			if char == 'A' {
				if s.validDiagonalX(x, y, -1, -1) && s.validDiagonalX(x, y, -1, 1) {
					s.result++
				}
			}
		}
	}
	return s.result
}

func (s *Shirt) searchPos(x, y, directionx, directiony int, current string) {
	if !s.isValid(x, y, current) {
		return
	}

	if done := current == "XMA" && s.Matrix[x][y] == 'S'; done {
		s.result++
		return
	}

	s.searchPos(x+directionx, y+directiony, directionx, directiony, current+string(s.Matrix[x][y]))
}

func (s *Shirt) validDiagonalX(x, y, directionx, directiony int) bool {
	firstOnDiag := s.Matrix[x+directionx][y+directiony]
	secondOnDiag := s.Matrix[x-directionx][y-directiony]
	if firstOnDiag == 'M' && secondOnDiag == 'S' {
		return true
	}
	if firstOnDiag == 'S' && secondOnDiag == 'M' {
		return true
	}
	return false
}

func (s Shirt) isValid(x, y int, current string) bool {
	if s.Matrix[x][y] == 'X' && current == "" ||
		s.Matrix[x][y] == 'M' && current == "X" ||
		s.Matrix[x][y] == 'A' && current == "XM" ||
		s.Matrix[x][y] == 'S' && current == "XMA" {
		return true
	}
	return false
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

func (s *Shirt) searchAllDirections(x, y int, char rune) {
	for dirx := -1; dirx <= 1; dirx++ {
		for diry := -1; diry <= 1; diry++ {
			if dirx == 0 && diry == 0 {
				continue
			}
			s.searchPos(x+dirx, y+diry, dirx, diry, string(char))
		}
	}
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
