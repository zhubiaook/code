package main

type Node struct {
	Data interface{}
	Next *Node
}

type LLink struct {
	VirtualHead *Node
	Length      int
}

// 初始化链表
func NewLLink() *LLink {
	return &LLink{VirtualHead: &Node{}}
}

// Linked List Add
func (l *LLink) Add(data interface{}) {
	headNode := l.VirtualHead.Next
	l.VirtualHead.Next = &Node{
		Data: data,
		Next: headNode,
	}
	defer func() { l.Length++ }()
}

// Linked List Append
func (l *LLink) Append(data interface{}) {
	tailNode := l.VirtualHead
	for tailNode.Next != nil {
		tailNode = tailNode.Next
	}
	tailNode.Next = &Node{
		Data: data,
		Next: nil,
	}
	defer func() { l.Length++ }()
}

// Linked List Insert
func (l *LLink) Insert(n int, data interface{}) {
	if n < 0 || n > l.Length {
		return
	}
	preNode := l.VirtualHead
	for i := 0; i < n; i++ {
		preNode = preNode.Next
	}
	latNode := preNode.Next
	preNode.Next = &Node{
		Data: data,
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
func (l *LLink) Scan() []interface{} {
	currNode := l.VirtualHead.Next
	var nodes []interface{}
	for currNode != nil {
		nodes = append(nodes, currNode.Data)
		currNode = currNode.Next
	}
	return nodes
}

func main() {
	ll := NewLLink()
	ll.Append(10)
	ll.Append(20)
	ll.Append(30)
	ll.Append(40)
	ll.Delete(3)
}
