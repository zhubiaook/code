package main

import (
	"fmt"
)

// 方法2：滑动窗口，通过map记录字符未重复的字符，方便判断字符是否存在map中
func lengthOfLongestSubstring(s string) int {
	var left, right, max int = 0, 0, 0
	chrmap := make(map[byte]bool)
	for right < len(s) {
		var subLen int
		_, ok := chrmap[s[right]]
		if ok {
			delete(chrmap, s[left])
			left++
		} else {
			chrmap[s[right]] = true
			right++
			subLen = right - left
		}
		if subLen > max {
			max = subLen
		}
	}
	return max
}

// 方法3：滑动窗口
// 利用ASCII字符只有128个特性及字符串返回的字节是整数，初始化一个数组，数组的索引位对应字符
func lengthOfLongestSubstring2(s string) int {
	var left, right, max int = 0, 0, 0
	var chrmap [128]bool
	for right < len(s) {
		var subLen int
		ok := chrmap[s[right]]
		if ok {
			chrmap[s[left]] = false
			left++
		} else {
			chrmap[s[right]] = true
			right++
			subLen = right - left
		}
		if subLen > max {
			max = subLen
		}
	}
	return max
}

func main() {
	s := "pwwkew"
	fmt.Println(lengthOfLongestSubstring(s))
}
