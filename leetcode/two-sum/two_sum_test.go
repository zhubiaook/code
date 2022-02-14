package main

import (
	"reflect"
	"testing"
)

func TestTwoSum(t *testing.T) {
	nums := []int{2, 7, 11, 15}
	target := 9
	ans := []int{0, 1}
	if v := twoSum(nums, target); !reflect.DeepEqual(v, ans) {
		t.Errorf("failed, %v", v)
	}
}
