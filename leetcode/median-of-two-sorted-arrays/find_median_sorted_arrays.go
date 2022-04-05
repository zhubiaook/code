package main

import "fmt"

func findMedianSortedArrays(nums1 []int, nums2 []int) float64 {
	if len(nums1) > len(nums2) {
		return findMedianSortedArrays(nums2, nums1)
	}

	var m, n int

	lenTotal := len(nums1) + len(nums2)

	// odd number
	if lenTotal%2 != 0 {
		m = len(nums1) / 2
		n = (lenTotal-1)/2 - m
		for !(nums1[m] < nums2[n] && nums2[n-1] < nums1[m+1]) {
			if nums1[m] > nums2[n] {
				m--
			}
			if nums1[m+1] < nums2[n-1] {
				m++
			}
			n = (lenTotal-1)/2 - m
		}
		return float64(max(nums1[m], nums2[n-1]))
	}

	// even number
	m = len(nums1) / 2
	n = lenTotal/2 - m - 1
	for !(nums1[m] < nums2[n] && nums2[n-1] < nums1[m+1]) {
		if nums1[m] > nums2[n] {
			m--
		}
		if nums1[m+1] < nums2[n-1] {
			m++
		}
		n = lenTotal/2 - m - 1
	}
	return float64(max(nums1[m], nums2[n-1])+min(nums1[m+1], nums2[n])) / 2
}

func max(num1, num2 int) int {
	if num1 > num2 {
		return num1
	}
	return num2
}

func min(num1, num2 int) int {
	if num1 < num2 {
		return num1
	}
	return num2
}

func main() {
	nums1 := []int{1, 3, 5}
	nums2 := []int{10, 12, 15}
	mid := findMedianSortedArrays(nums1, nums2)
	fmt.Println(mid)
}
