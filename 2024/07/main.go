package main

import (
	"strconv"
	"strings"
)

func Calculate(equations string) (res int) {
	lines := strings.Split(equations, "\n")
	for _, line := range lines {
		equation := strings.Split(line, ":")
		numbers := strings.Split(strings.TrimSpace(equation[1]), " ")
		wantedResult, _ := strconv.Atoi(equation[0])
		operations := opCombinations([]string{"+", "*"}, len(numbers)-1)
		solvs := make([]int, len(operations))
		for opIndex, op := range operations {
			for i, number := range numbers {
				num, _ := strconv.Atoi(number)
				if i == 0 {
					solvs[opIndex] = num
				} else if op[i-1] == '+' {
					solvs[opIndex] += num
				} else if op[i-1] == '*' {
					solvs[opIndex] *= num
				}
			}
		}
		for _, solv := range solvs {
			if solv == wantedResult {
				res += wantedResult
				break
			}
		}
	}
	return res
}

// Here we include concatenation as the third operation
func CalculateAdvanced(equations string) (res int) {
	lines := strings.Split(equations, "\n")
	for _, line := range lines {
		equation := strings.Split(line, ":")
		numbers := strings.Split(strings.TrimSpace(equation[1]), " ")
		wantedResult, _ := strconv.Atoi(equation[0])
		operations := opCombinations([]string{"+", "*", "|"}, len(numbers)-1)
		solvs := make([]int, len(operations))
		for opIndex, op := range operations {
			for i, number := range numbers {
				num, _ := strconv.Atoi(number)
				if i == 0 {
					solvs[opIndex] = num
				} else if op[i-1] == '+' {
					solvs[opIndex] += num
				} else if op[i-1] == '*' {
					solvs[opIndex] *= num
				} else if op[i-1] == '|' {
					solvs[opIndex], _ = strconv.Atoi(strconv.Itoa(solvs[opIndex]) + strconv.Itoa(num))
				}
			}
		}
		for _, solv := range solvs {
			if solv == wantedResult {
				res += wantedResult
				break
			}
		}
	}
	return res

}

// For opCombinations([]string{"+", "*"}, 3): +++ ++* +*+ +** *++ *+* **+ ***
func opCombinations(ops []string, numLeft int) []string {
	if numLeft == 1 {
		return ops // e.g. []string{"+", "*"}
	}
	var combinations []string
	for _, alreadyGeneratedOp := range opCombinations(ops, numLeft-1) {
		for _, op := range ops {
			combinations = append(combinations, op+alreadyGeneratedOp)
		}
	}

	return combinations
}
