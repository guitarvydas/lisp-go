package main

import "C"

import (
	"fmt"
	"math"
	"sort"
	"sync"
)

var mtx sync.Mutex

//export Add
func Add(a, b int) int {
	return a + b
}

//export Cosine
func Cosine(x float64) float64 {
     // fmt.Printf("Go cos(%f) -> %f\n", x, math.Cos(x))
	return math.Cos(x)
}

//export Sort
func Sort(vals []int) {
	sort.Ints(vals)
}

//export Hello
func Hello() {
	mtx.Lock()
	defer mtx.Unlock()
	fmt.Println("Hello from GO")
}

// Go strings from Lisp are still a problem

//export Log
func Log(msg string) {
	mtx.Lock()
        defer mtx.Unlock()
	fmt.Println(msg)
}

func main() {}
