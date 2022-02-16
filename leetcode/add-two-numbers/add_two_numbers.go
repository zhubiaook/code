package main

func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode {
	head := &ListNode{0, nil}
	curr := head
	carry := 0
	for l1 != nil || l2 != nil || carry > 0 {
		n1 := 0
		n2 := 0
		if l1 != nil {
			n1 = l1.Val
			l1 = l1.Next
		}
		if l2 != nil {
			n2 = l2.Val
			l2 = l2.Next
		}

		remain := (n1 + n2 + carry) % 10
		carry = (n1 + n2 + carry) / 10
		curr.Next = &ListNode{remain, nil}
		curr = curr.Next
	}
	return head.Next
}
