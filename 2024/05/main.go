package main

import (
	"slices"
	"strconv"
	"strings"
)

type Print struct {
	Rules          map[Pair]Rule
	Updates        []Update
	ValidUpdates   []Update
	InvalidUpdates []Update
	result         int
}

type Update []int

type Pair struct {
	First, Second int
}

type Rule int

const (
	_ Rule = iota
	FirstBeforeSecond
	FirstAfterSecond
)

func NewPrint(rawRules, rawUpdates string) Print {
	rules := strings.Split(rawRules, "\n")
	ruleMap := make(map[Pair]Rule, len(rules))
	for _, line := range rules {
		pages := strings.Split(line, "|")
		n1, _ := strconv.Atoi(pages[0])
		n2, _ := strconv.Atoi(pages[1])
		ruleMap[Pair{n1, n2}] = FirstBeforeSecond
		ruleMap[Pair{n2, n1}] = FirstAfterSecond
	}

	updateStrings := strings.Split(rawUpdates, "\n")
	updates := make([]Update, len(updateStrings))

	for i, line := range updateStrings {
		for _, num := range strings.Split(line, ",") {
			n, _ := strconv.Atoi(num)
			updates[i] = append(updates[i], n)
		}
	}

	return Print{Rules: ruleMap, Updates: updates}
}

func (p *Print) MiddleSum() (res int) {
	p.calculate()

	for _, update := range p.ValidUpdates {
		res += update[len(update)/2]
	}
	return res
}

func (p *Print) InvalidSum() (res int) {
	p.calculate()
	p.SortInvalid()

	for _, update := range p.InvalidUpdates {
		res += update[len(update)/2]
	}
	return res
}

func (p *Print) SortInvalid() {
	for _, update := range p.InvalidUpdates {
		slices.SortFunc(update, p.comparePages)
	}
}

func (p *Print) comparePages(a, b int) int {
	if p.Rules[Pair{a, b}] == FirstBeforeSecond {
		return -1
	}
	if p.Rules[Pair{a, b}] == FirstAfterSecond {
		return 1

	}
	return 0
}

func (p *Print) calculate() {
	for _, update := range p.Updates {
		valid := true
		for i, num := range update[:len(update)-1] {
			for _, num2 := range update[i+1:] {
				if p.Rules[Pair{num, num2}] == FirstAfterSecond {
					valid = false
					break
				}
			}

		}
		if valid {
			p.ValidUpdates = append(p.ValidUpdates, update)
		} else {
			p.InvalidUpdates = append(p.InvalidUpdates, update)
		}
	}
}
