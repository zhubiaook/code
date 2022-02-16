package main

type Node struct {
	Data interface{}
	Next *Node
}

type LLink struct {
	Heard  *Node
	Length int
}

// Linked List Add
func (l *LLink) Add() {}

// Linked List Append
func (l *LLink) Append() {}

// Linked List Insert
func (l *LLink) Insert() {}

// Linked List Delete
func (l *LLink) Delete() {}

// Linked List Scan
func (l *LLink) Scan() {}

func main() {
}
