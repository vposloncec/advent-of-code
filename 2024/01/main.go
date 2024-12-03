package main

import (
	"slices"
	"strconv"
	"strings"
)

func main() {

	var example = `3   4
4   3
2   5
1   3
3   9
3   3`

	calculate(example)
}

func calculate(rawInput string) (res int) {
	s1 := []int{}
	s2 := []int{}
	for _, line := range strings.Split(rawInput, "\n") {
		elems := strings.Fields(line)
		num1, _ := strconv.Atoi(elems[0])
		num2, _ := strconv.Atoi(elems[1])
		s1 = append(s1, num1)
		s2 = append(s2, num2)
	}
	slices.Sort(s1)
	slices.Sort(s2)

	for i := 0; i < len(s1); i++ {
		if s1[i] > s2[i] {
			res += s1[i] - s2[i]
		} else {
			res += s2[i] - s1[i]
		}
	}
	return res
}

func similarity(rawInput string) (res int) {
	s1 := []int{}
	occurances2 := make(map[int]int)
	for _, line := range strings.Split(rawInput, "\n") {
		elems := strings.Fields(line)
		num1, _ := strconv.Atoi(elems[0])
		num2, _ := strconv.Atoi(elems[1])
		s1 = append(s1, num1)
		occurances2[num2]++
	}
	for _, num := range s1 {
		res += num * occurances2[num]
	}

	return res
}
