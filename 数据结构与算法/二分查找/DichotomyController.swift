//
//  DichotomyController.swift
//  数据结构与算法
//
//  Created by ouyangqi on 2023/1/4.
//

import UIKit

extension Array {
    
    mutating func mySorted(_ method : (Element, Element) -> Bool) -> [Element] {
        for j in 0..<self.count {
            for i in 1..<self.count - j {
                if method(self[i], self[i - 1]) {
                    self.swapAt(i, i - 1)
                }
            }
        }
        return self
    }
    
}
    

class DichotomyController: UIViewController {
    
    var perArray = [[Int]]()
    var array = [[Int]]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        print(twoSum([2,7,11,15], 9))
//
//        print(isValid("{[]}"))
//        var array = [3,2,2,3]
//        print(removeElement(&array, 3), array)
        
//        print(permute([1, 2, 3, 4]))
        
        
//        print(lengthOfLastWord("   fly me   to   the moon  "))
//        print(plusOne([4,3,2,9]))

        
//        print(generate(5))
//
//        let cache = LRUCache(2)
//        cache.put(1, 1);
//        cache.put(2, 2);
//        cache.get(1);       // 返回  1
//        cache.put(3, 3);    // 该操作会使得密钥 2 作废
//        cache.get(2);       // 返回 -1 (未找到)
//        cache.put(4, 4);    // 该操作会使得密钥 1 作废
//        cache.get(1);       // 返回 -1 (未找到)
//        cache.get(3);       // 返回  3
//        cache.get(4);       // 返回  4
        //49-57  .46 + 43 -45  空格32

        


//        print(convert("PAYPALISHIRING", 3))
//        array = [[1,3],[15,18],[2,6],[8,10]]
        
//        fastSort(left: 0, right: array.count)
//        print(array)
//        print(merge(array))
        
//        print(canJump([1,1,1,0]))
//        "Let's take LeetCode contest"
//        print(reverseWords("Let's take LeetCode contest"))

        
        print(productExceptSelf([1, 2, 3, 4]))
        
        var arr = [1, 3, 5, 2]
        let a = arr.sorted { a, b in
            a > b
        }
        print(a)
        
        
        let b = arr.mySorted { a, b in
            a > b
        }
        print(b)
    }


    
    
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var result = Array(repeating: 1, count: nums.count)
        var p = 1
        var q = 1
        for (i, val) in nums.enumerated() {
            result[i] = p
            p *= val
        }

        for (j, val) in nums.enumerated().reversed() {
            result[j] *= q
            q *= val
        }

        return result
    }
    
    func reverseWords(_ s: String) -> String {
        var result = ""
        var kw = ""
        for (i, c) in s.enumerated().reversed() {
            if c == " " || i == 0 {
                if i == 0 {
                    kw.append(c)
                }
                let str = (result.count > 0) ? " " + result : result
                result = kw + str
                kw = ""
            } else {
                kw.append(c)
            }
        }
        return result
    }
    
    
    /*
     300
     300
     4500
     500
     500
     100
     
     800
     200
     2600
     
     10000
     
     
     */
    //[3,2,1,0,4]
    func canJump(_ nums: [Int]) -> Bool {
        guard nums.count > 1 else {
            return true
        }
        var isDangrous = false
        var temp = 0
        for (i, num) in nums.enumerated().reversed() {
            if num == 0 {
                isDangrous = true
            }
            if isDangrous {
                if num > temp {
                    isDangrous = false
                    temp = 0
                } else if i == nums.count - 1 {
                    isDangrous = false
                } else {
                    temp += 1
                }
            }
        }
        return !isDangrous
    }
    
    
    
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        self.array = intervals
//        fastSort(left: 0, right: array.count)

        self.array = self.array.sorted { a, b in
            return a.first! < b.first!
        }
        
        var arr = [[Int]]()
        arr.append(array.first!)
        for i in 1..<array.count {
            let temp = arr.last!
            if temp.last! > array[i].first! {
                let maxx = max(temp.last!, array[i].last!)
                arr.removeLast()
                arr.append([temp.first!, maxx])
            } else {
                arr.append(array[i])
            }
        }


        return arr
    }
    
    func fastSort(left: Int, right: Int) {
        if right - left < 2 {
            return
        }
        let mid = findMid(left: left, right: right)
        fastSort(left: left, right: mid)
        fastSort(left: mid + 1, right: right)
        return
    }
    
    func findMid(left: Int, right: Int) -> Int {
        var left = left
        var right = right
        let n = array[left]
        let num = array[left].first!
        right -= 1
        
        while left < right {
            
            while left < right {
                if array[right].first! > num {
                    right -= 1
                } else {
                    array[left] = array[right]
                    left += 1
                    break
                }
            }
            
            while left < right {
                if array[left].first! < num {
                    left += 1
                } else {
                    array[right] = array[left]
                    right -= 1
                    break
                }
            }

        }
        
        array[left] = n
        
        
        return left
        
    }
    
    
    
    
    
    func convert(_ s: String, _ numRows: Int) -> String {
        var array = Array(repeating: [String](), count: numRows)
        let arr = Array(s)
        var count = 0
        var isUp = false
        for c in s {
            if count == numRows - 1 {
                isUp = true
            }
            if count == 0 {
                isUp = false
            }
            array[count].append(String(c))
            if isUp {
                count -= 1
            } else {
                count += 1
            }
        }
        
        var str = ""
        for a in array {
            var s = ""
            a.map { st in
                s += st
            }
            str += s
        }
        return str
    }
    
    
    
    
    
    
    class LinkNode {
        var val: Int = 0
        var key: Int = 0
        var next: LinkNode?
        var pre: LinkNode?
        init(_ val: Int,_ key: Int) {
            self.val = val
            self.key = key
        }
    }
    
    
    class LRUCache {
        var capacity: Int!
        var begin = LinkNode(0, 0)
        var end = LinkNode(0, 0)
        var map = [Int: LinkNode]()

        init(_ capacity: Int) {
            self.capacity = capacity
            begin.next = end
            end.pre = begin
        }
        
        func get(_ key: Int) -> Int {
            let node = map[key]
            remove(node: node)
            inserToFirst(node: node)
            return node?.val ?? -1
        }
        
        func put(_ key: Int, _ value: Int) {
            if let node = map[key] {
                node.val = value
                remove(node: node)
                inserToFirst(node: node)
            } else {
                let node = LinkNode(value, key)
                if map.count >= capacity {
                    remove(node: end.pre)
                }
                inserToFirst(node: node)
            }
        }
        
        func remove(node: LinkNode?) {
            if let node = node {
                node.pre?.next = node.next
                node.next?.pre = node.pre
                map.removeValue(forKey: node.key)
            }
        }
        
        func inserToFirst(node: LinkNode?) {
            if let node = node {
                node.next = begin.next
                begin.next?.pre = node
                node.pre = begin
                begin.next = node
                map[node.key] = node
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func generate(_ numRows: Int) -> [[Int]] {
        var numRows = numRows
        var arr = [[Int]]()
        var pre: Array<Int>? = nil
        while numRows > 0 {
            if pre != nil {
                var pre1 = [0] + pre!
                var pre2 = pre! + [0]
                var a = [Int]()
                for i in 0...pre!.count {
                    a.append(pre1[i] + pre2[i])
                }
                pre = a
                arr.append(a)
            } else {
                pre = [1]
                arr.append(pre!)
            }
            numRows -= 1
        }
        return arr
    }
    
    
    func plusOne(_ digits: [Int]) -> [Int] {
        var array = digits
        var n = 1
        for (i, num) in array.enumerated().reversed() {
            let m = num + n
            array[i] = m % 10
            n = m / 10
            if n == 0 {
                break
            }
        }
        if n > 0 {
            array.insert(n, at: 0)
        }
        return array
    }
    
    func lengthOfLastWord(_ s: String) -> Int {
        var count = 0
        var begin = false

        for c in s.reversed() {
            if c == " ", !begin {
                continue
            } else if c != " " {
                count += 1
                begin = true
            } else {
                break
            }
        }
        return count
    }
    
    
    func permute(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 1 else { return [nums] }

        for (i, value) in nums.enumerated() {
            
            
            
            
        }


        return perArray
    }
    
    func meth(curArray: [Int], array: inout [[Int]]) -> [Int] {
        if curArray.count == 1 {
            return curArray
        }
        
        let arr1 = [curArray[0]] + meth(curArray: Array(curArray[1..<curArray.count]), array: &array)
        array.append(arr1)
        let arr2 = meth(curArray: Array(curArray[1..<curArray.count]), array: &array) + [curArray[0]]
        array.append(arr2)
        return [Int]()
    }
    
    
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var i = 0
        var j = 0
        while j < nums.count {
            if val != nums[j] {
                nums[i] = nums[j]
                i += 1
            }
            j += 1
        }
        return i
    }
    
    func isValid(_ s: String) -> Bool {
        let array = Array(s)
        var stack = [String]()
        var pre = ""
        for i in 0..<array.count {
            let s = String(array[i])
            if isEq(s1: pre, s2: s) {
                stack.removeLast()
            } else {
                stack.append(s)
            }
            pre = stack.last ?? ""
        }
        return stack.isEmpty
    }
    
    func isEq(s1: String, s2: String) -> Bool {
        if s1 == "(", s2 == ")" {
            return true
        } else if s1 == "[", s2 == "]" {
            return true
        } else if s1 == "{", s2 == "}" {
            return true
        }
        return false
    }
    
    
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var i = 0
        var j = numbers.count - 1
        
        while i < numbers.count, j >= 0 {
            let num = numbers[i] + numbers[j]
            if num == target {
                return [i + 1, j + 1]
            } else if num > target {
                j -= 1
            } else {
                i += 1
            }
        }
        
        return [Int]()
    }
    
    
    
    func findPeakElement(_ nums: [Int]) -> Int {
        var left = 0
        var right = nums.count - 1
        
        while left < right {
            let mid = (right - left) / 2 + left
            if nums[mid] > nums[mid + 1] {
                right = mid
            } else {
                left = mid + 1
            }
        }
        
        return left
    }
    
    
    

    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = (right - left) / 2 + left
            if nums[mid] < target {
                left = mid + 1
            } else if nums[mid] > target {
                right = mid - 1
            } else {
                return mid
            }
        }
        return left
    }
    
    
    func search(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 0 else {
            return -1
        }
        var b = 0
        var e = nums.count  - 1
        
        while b <= e {
            let mid = b + (e - b) / 2
            if nums[mid] == target {
                return mid
            }
            //前半段有序
            if nums[b] <= nums[mid] {
                if nums[b] <= target, nums[mid] > target {
                    e = mid - 1
                } else {
                    b = mid + 1
                }
            } else {
                if nums[e] >= target, nums[mid] < target {
                    b = mid + 1
                } else {
                    e = mid - 1
                }
            }
        }
        return -1
    }
    

    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        guard nums.count > 0 else {
            return [-1, -1]
        }
        var left = 0
        var right = nums.count - 1
        
        while left < right {
            let mid = (right + left) / 2
            if nums[mid] >= target {
                right = mid
            } else {
                left = mid + 1
            }
        }
        if target != nums[right] {
            return [-1, -1]
        }

        for i in left..<nums.count {
            if nums[i] == target {
                right = i
            } else {
                break
            }
        }
  
        return [left, right]
    }
    
    
    
    
    
    
    
}
