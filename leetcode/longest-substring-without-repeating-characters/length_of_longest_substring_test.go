package main

import "testing"

func TestLengthOfLongestSubstring(t *testing.T) {
	s := "pwwkew"
	ans := 3
	if lengthOfLongestSubstring(s) != ans {
		t.Errorf("failed")
	}
}

func TestLengthOfLongestSubstring2(t *testing.T) {
	s := "pwwkew"
	ans := 3
	if lengthOfLongestSubstring2(s) != ans {
		t.Errorf("failed")
	}
}
