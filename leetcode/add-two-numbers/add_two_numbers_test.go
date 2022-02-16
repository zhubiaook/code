package main

import (
	"reflect"
	"testing"
)

func convertSliceToListNode(nums []int) *ListNode {
	ll := NewLLink()
	for _, v := range nums {
		ll.Append(v)
	}
	l := ll.VirtualHead.Next
	return l
}

func TestAddTwoNumbers(t *testing.T) {
	n1 := []int{2, 4, 3}
	n2 := []int{5, 6, 4}
	ans := []int{7, 0, 8}

	l1 := convertSliceToListNode(n1)
	l2 := convertSliceToListNode(n2)
	ls := addTwoNumbers(l1, l2)
	lls := NewLLink()
	lls.VirtualHead.Next = ls
	ns := lls.Scan()

	if !reflect.DeepEqual(ans, ns) {
		t.Error("faild")
	}

}
