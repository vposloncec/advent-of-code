package main

import (
	"fmt"
	"regexp"
	"strconv"
)

func mul(input string) (res int) {
	matches := mulRegex().FindAllStringSubmatch(input, -1)
	for _, match := range matches {
		n1, _ := strconv.Atoi(match[1])
		n2, _ := strconv.Atoi(match[2])
		res += n1 * n2
	}
	return res
}

func mulConditional(input string) (res int) {
	input = `do()` + input + `don't()`
	matchGroup := doGroupRegex().FindAllStringSubmatch(input, -1)
	for _, match := range matchGroup {
		res += mul(match[1])
	}
	return res
}

func doGroupRegex() *regexp.Regexp {
	regex := fmt.Sprintf(
		`%v(.*?)%v`,
		doRegex().String(),
		dontRegex().String())
	return regexp.MustCompile(regex)
}

func mulRegex() *regexp.Regexp {
	return regexp.MustCompile(`mul\((\d+),(\d+)\)`)
}

func doRegex() *regexp.Regexp {
	return regexp.MustCompile(`do\(\)`)
}

func dontRegex() *regexp.Regexp {
	return regexp.MustCompile(`don't\(\)`)
}
