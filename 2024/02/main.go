package main

import (
	"strconv"
	"strings"
)

func main() {
}

func safe(rawInput string) (res int) {
	for _, line := range strings.Split(rawInput, "\n") {
		safe := checkLevel(strings.Fields(line))
		if safe {
			res++
		}
	}
	return res
}

func checkLevel(level []string) bool {
	var lastInput int
	var increasing bool
	safe := true
	for i, elem := range level {
		num, _ := strconv.Atoi(elem)
		if i == 0 {
			lastInput = num
			continue
		}
		if i == 1 {
			increasing = num > lastInput
		}
		if num > lastInput != increasing {
			safe = false
		}

		diff := num - lastInput
		if diff < 0 {
			diff = -diff
		}

		if diff == 0 || diff > 3 {
			safe = false
		}

		if !safe {
			break
		}
		lastInput = num
	}
	return safe
}

func safeDampened(rawInput string) (res int) {
	for _, line := range strings.Split(rawInput, "\n") {
		fields := strings.Fields(line)
		safe := checkLevel(fields)
		if !safe {
			for i := 0; i < len(fields); i++ {
				newFields := make([]string, len(fields))
				copy(newFields, fields)
				newFields = append(newFields[:i], newFields[i+1:]...)
				if checkLevel(newFields) {
					safe = true
					break
				}
			}
		}
		if safe {
			res++
		}
	}
	return res
}
