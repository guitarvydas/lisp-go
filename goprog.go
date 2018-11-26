package main

import "C"

import (
	"fmt"
	"math"
	"sort"
	"sync"
)

var count int
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

//export Count1
func Count1 (msg string) int {
     return len(msg)
}

//export Count01
func Count01 () int {
     msg := "abc"
     return Count1(msg)
}

//export Count0
func Count0 () int {
     msg := "abc"
     return len(msg)
}

//export LogAndCount
func LogAndCount(msg string) int {
	mtx.Lock()
	defer mtx.Unlock()
	fmt.Println(msg)
	count++
	return count
}


func main() {}
