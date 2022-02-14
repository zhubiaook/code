package main

func twoSum(nums []int, target int) []int {
	m := make(map[int]int)
	for i, v := range nums {
		other := target - v
		if j, ok := m[other]; ok {
			return []int{j, i}
		}
		m[v] = i
	}
	return nil
}
