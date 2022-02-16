package main

type ListNode struct {
	Val  int
	Next *ListNode
}

type LLink struct {
	VirtualHead *ListNode
	Length      int
}

// 初始化链表
func NewLLink() *LLink {
	return &LLink{VirtualHead: &ListNode{}}
}

// Linked List Add
func (l *LLink) Add(data int) {
	headNode := l.VirtualHead.Next
	l.VirtualHead.Next = &ListNode{
		Val:  data,
		Next: headNode,
	}
	defer func() { l.Length++ }()
}

// Linked List Append
func (l *LLink) Append(data int) {
	tailNode := l.VirtualHead
	for tailNode.Next != nil {
		tailNode = tailNode.Next
	}
	tailNode.Next = &ListNode{
		Val:  data,
		Next: nil,
	}
	defer func() { l.Length++ }()
}

// Linked List Insert
func (l *LLink) Insert(n int, data int) {
	if n < 0 || n > l.Length {
		return
	}
	preNode := l.VirtualHead
	for i := 0; i < n; i++ {
		preNode = preNode.Next
	}
	latNode := preNode.Next
	preNode.Next = &ListNode{
		Val:  data,
		Next: latNode,
	}
	defer func() { l.Length++ }()
}

// Linked List Delete
func (l *LLink) Delete(n int) {
	if n < 0 || n > l.Length-1 {
		return
	}
	preNode := l.VirtualHead
	for i := 0; i < n; i++ {
		preNode = preNode.Next
	}
	latNode := preNode.Next.Next
	preNode.Next = latNode
	defer func() { l.Length-- }()
}

// Linked List Scan
func (l *LLink) Scan() []int {
	currNode := l.VirtualHead.Next
	var nodes []int
	for currNode != nil {
		nodes = append(nodes, currNode.Val)
		currNode = currNode.Next
	}
	return nodes
}
