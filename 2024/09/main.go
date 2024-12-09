package main

import (
	"strconv"
	"strings"
)

type Defragmenter struct {
	input          string
	representation string
	defragmented   string
	checksum       int
}

func NewDefragmenter(input string) *Defragmenter {
	return &Defragmenter{input: input}
}

func (d *Defragmenter) Calculate() int {
	d.createRepresentation()
	d.defragment()
	d.calculateChecksum()

	return d.checksum
}

func (d *Defragmenter) createRepresentation() {
	charIndex := 0
	var out strings.Builder
	for _, c := range d.input {
		count, _ := strconv.Atoi(string(c))
		if charIndex%2 == 0 {
			out.WriteString(strings.Repeat(strconv.Itoa(charIndex/2), count))
		} else {
			out.WriteString(strings.Repeat(".", count))
		}
		charIndex++
	}
	d.representation = out.String()
}

func (d *Defragmenter) defragment() {
	defragmented := d.representation
	for {
		dotIndex := strings.Index(defragmented, ".")
		rightIndex := strings.LastIndexFunc(defragmented, func(r rune) bool { return r != '.' })
		if dotIndex >= rightIndex {
			break
		}
		defragmented = swap(defragmented, dotIndex, rightIndex)
	}
	d.defragmented = defragmented
}

func (d *Defragmenter) calculateChecksum() {
	parts := strings.SplitN(d.defragmented, ".", 2)
	firstPart := parts[0]
	sum := 0
	for i, c := range firstPart {
		num, _ := strconv.Atoi(string(c))
		sum += num * i
	}
	d.checksum = sum
}

func swap(s string, i, j int) string {
	r := []rune(s)
	r[i], r[j] = r[j], r[i]
	return string(r)
}
