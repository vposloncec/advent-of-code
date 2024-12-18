package main

type Prioritable interface {
	Value() int
	String() string
}

type PriorityQueue []Prioritable

func (p PriorityQueue) Len() int           { return len(p) }
func (p PriorityQueue) Less(i, j int) bool { return p[i].Value() < p[j].Value() }
func (p PriorityQueue) Swap(i, j int)      { p[i], p[j] = p[j], p[i] }

func (p *PriorityQueue) Push(x any) {
	// Push and Pop use pointer receivers because they modify the slice's length,
	// not just its contents.
	*p = append(*p, x.(Prioritable))
}

func (p *PriorityQueue) Pop() any {
	old := *p
	n := len(old)
	x := old[n-1]
	*p = old[:n-1]
	return x
}

func (p *PriorityQueue) String() string {
	var str string
	for _, v := range *p {
		str += v.String() + "\n"
	}
	return str
}
