package main

import (
	"testing"
)

var example = `MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX`

var examplePretty = `....XXMAS.
.SAMXMS...
...S..A...
..A.A.MS.X
XMASAMX.MM
X.....XA.A
S.S.S.S.SS
.A.A.A.A.A
..M.M.M.MM
.X.X.XMASX`

func TestPrettify(t *testing.T) {
	tests := []struct {
		name  string
		input string
		want  string
	}{
		{
			name:  "example",
			input: example,
			want:  examplePretty,
		},
	}
	for _, tt := range tests {
		shirt := NewShirt(tt.input)
		t.Run(tt.name, func(t *testing.T) {
			if got := shirt.String(); got != tt.want {
				t.Errorf("calculate = \n%v\nwant: \n%v", got, tt.want)
			}
		})
	}
}

var input = `asdf`
