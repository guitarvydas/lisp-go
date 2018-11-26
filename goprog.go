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

//export Log
func Log(msg string) {
	mtx.Lock()
	defer mtx.Unlock()
	fmt.Println(msg)
}

//export LogAndCount
func LogAndCount(msg string) int {
	mtx.Lock()
	defer mtx.Unlock()
	fmt.Println(msg)
	count++
	return count
}

//export GoStrlen
func LogAndCount(msg string) int {
	mtx.Lock()
	defer mtx.Unlock()
	fmt.Println(msg)
	count++
	return count
}


func main() {}
