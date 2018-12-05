package main

import "C"

import (
	"fmt"
	"sync"
)

var mtx sync.Mutex

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

func main() {}
