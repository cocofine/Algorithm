//
//  ClassicController.swift
//  数据结构与算法
//
//  Created by ouyangqi on 2022/12/18.
//

import UIKit

class ClassicController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        var A = [0]
//        var B = [Int]()
//        var C = [Int]()
//        hanota(&A, &B, &C)
//        print(A, B, C)
        
//        trips = [[2,1,5],[3,3,7]], capacity = 4
//        print(judgeSquareSum(2))
//        print(longestPalindrome("ccc"))
        
//        var height = [0,1,0,2,1,0,1,3,2,1,2,1]
        
//        print(trap2(height))
//        print(method(n: 5))
//        print(threeSum([-1,0,1,2,-1,-4]))
//        print(threeSumClosest([1, 1, 1, 1], -100))
//        print(multiply("123", "456"))
        
//        print(maxProfit([7,1,5,3,6,4]))
//        var a = [1,2,3,0,0,0]
//        merge(&a, 3, [2,5,6], 3)
//        print(a)
        
//        print(spiralOrder([[1,2,3,4],[5,6,7,8],[9,10,11,12]]))
//        print(letterCombinations("23"))
//        print(mettengRoom([[9, 12], [10, 11], [14, 18], [15, 17], [16, 19]]))
        print(search([4,5,6,7,0,1,2], 0))
    }
    
    //====================搜索旋转排序数组====================
    //输入：nums = [4,5,6,7,0,1,2], target = 0
    //输出：4
    func search(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 0 else { return -1 }
        var i = 0
        var j = nums.count - 1
        
        while i <= j {
            let mid = (j - i) / 2 + i
            if nums[mid] == target {
                return mid
            }
            
            if nums[i] <= nums[mid] {
                if nums[i] <= target, target < nums[mid] {
                    j = mid - 1
                } else {
                    i = mid + 1
                }
            } else {
                if nums[mid] < target, target <= nums[j] {
                    i = mid + 1
                } else {
                    j = mid - 1
                }
            }
        }
        return -1
    }
    
    
    
    
    //=====================会议室=======================
    //9 10 14 15 16
    //11 12 17 18 19
    //  0 5 15
    //  10 20 30
    func mettengRoom(_ mettings: [[Int]]) -> Int {
        guard mettings.count > 1 else { return mettings.count }
        var start = [Int]()
        var end = [Int]()
        for arr in mettings {
            start.append(arr[0])
            end.append(arr[1])
        }
        start = start.sorted(by: <)
        end = end.sorted(by: <)
        
        var res = 0
        var j = 0
        for i in 0..<mettings.count {
            let s = start[i]
            let e = end[j]
            if s < e {
                res += 1
            } else {
                j += 1
            }
            
        }
        return res
    }
    
    
    //==================最长连续序列=====================
    func longestConsecutive(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return nums.count
        }
        var sets = Set<Int>()
        for num in nums {
            sets.insert(num)
        }
        
        var longest = 0
        for num in nums {
            var cur = 0
            if !sets.contains(num - 1) {
                while sets.contains(num + 1) {
                    cur += 1
                }
            }
            longest = min(longest, cur + 1)
        }
        

        return longest
    }
    
    
        
    //=================括号生成===================
    
    var bracketArray = [String]()
    func generateParenthesis(_ n: Int) -> [String] {
        bracketDFS("", n, n)
        return bracketArray
    }

    func bracketDFS(_ curStr: String, _ left: Int, _ right: Int) {
        if left == 0, right == 0 {
            bracketArray.append(curStr)
            return
        }

        if left > right {
            return
        }

        if left > 0 {
            bracketDFS(curStr + "(", left - 1, right)
        }

        if right > 0 {
            bracketDFS(curStr + ")", left, right - 1)
        }
    }
    
    
    
//    ======================电话号码的字母组合===========================
    //给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。答案可以按 任意顺序 返回。
    //给出数字到字母的映射如下（与电话按键相同）
    func letterCombinations(_ digits: String) -> [String] {
        guard digits.count > 0 else { return [] }
        let phone = ["abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]

        var nums = Array(digits)
        var queue = [String]()

        let f = Int(String(nums.removeFirst()))!
        let phoneArray = Array(String(phone[f - 2])).map({String($0)})
        queue.append(contentsOf: phoneArray)

        while nums.count > 0 {
            let f = Int(String(nums.removeFirst()))!
            let phoneArray = Array(String(phone[f - 2])).map({String($0)})

            var temp = [String]()
            while queue.count > 0 {
                let first = queue.removeFirst()
                for n in phoneArray {
                    temp.append(first + n)
                }
            }
            queue = temp


        }

        return queue

    }
    
    
    //==========================全排列==============================
    var res = [[Int]]()
    func permute(_ nums: [Int]) -> [[Int]] {
        var visiteds = Array.init(repeating: false, count: nums.count)
        dfs(nums: nums, path: [], visiteds: &visiteds)
        return res
    }
    
    func dfs(nums: [Int], path: [Int], visiteds: inout [Bool]) {
        if path.count == nums.count {
            res.append(path)
            return
        }
        for (i, _) in nums.enumerated() {
            if visiteds[i] == true {
                continue
            }
            visiteds[i] = true
            let newPath = [nums[i]] + path
            dfs(nums: nums, path: newPath, visiteds: &visiteds)
            visiteds[i] = false
        }
    }
    
    //=======================字符串相乘===========================
    func multiply(_ num1: String, _ num2: String) -> String {
        guard num1 != "0", num2 != "0" else { return "0" }
        let arr1 = Array(num1)
        let arr2 = Array(num2)
        var sum = 0
        
        for (i, val1) in arr1.reversed().enumerated() {
            let v1 = (Int(String(val1))! * Int(pow(10.0, Double(i))))
            for (j, val2) in arr2.reversed().enumerated() {
                let n = v1 * Int(String(val2))!
                sum += (n * Int(pow(10.0, Double(j))))
            }
        }
        return String(sum)
    }
    
    
    //======================整数转罗马============================
    func intToRoman(_ num: Int) -> String {
        var num = num
        let numArr = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        let strArr = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        var romanStr = ""
        for (i, val) in numArr.enumerated() {
            while num >= val {
                num -= val
                romanStr += strArr[i]
            }
        }
        return romanStr
    }
    
    
    //======================三数之和========================
    //输入：nums = [-1,0,1,2,-1,-4]
   // 输出：[[-1,-1,2],[-1,0,1]]
//    解释：
//    nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0 。
//    nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0 。
//    nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0 。
//    不同的三元组是 [-1,0,1] 和 [-1,-1,2] 。

    func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 2 else {
            return [[Int]]()
        }
        let nums = nums.sorted(by: <)
        var array = [[Int]]()
        
        for i in 0..<nums.count {
            var left = i + 1
            var right = nums.count - 1
            if(nums[i] > 0) { break } // 如果当前数字大于0，则三数之和一定大于0，所以结束循环
            if i > 0, nums[i] == nums[i-1] {continue} // 去重
            while left < right {
                let sum = nums[i] + nums[left] + nums[right]
                if sum == 0 {
                    array.append([nums[i], nums[left], nums[right]])
                    while left < right, nums[left] == nums[left + 1] {
                        left += 1
                    }
                    while left < right, nums[right] == nums[right - 1] {
                        right -= 1
                    }
                    right -= 1
                    left += 1
                } else if sum > 0 {
                    right -= 1
                } else {
                    left += 1
                }
            }
        }
        
        return array
    }
    
    
    //====================最大子数组和======================
    //[-2,1,-3,4,-1,2,1,-5,4] 合为6, 即[4,-1,2,1]
    func maxSubArray(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        
        var array = Array.init(repeating: 0, count: nums.count)
        array[0] = nums[0]
        var maxx = nums[0]
        
        for i in 1..<nums.count {
            if array[i - 1] > 0 {
                array[i] = array[i - 1] + nums[i]
            } else {
                array[i] = nums[i]
            }
            maxx = max(maxx, array[i])
        }
        return maxx
    }
    
    
    //===================螺旋矩阵=======================
    //1   2  3  4
    //10 11 12 5
    //9  8  7  6
    
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var count = matrix.count * matrix[0].count
        var top = 0
        var left = 0
        var bottom = matrix.count - 1
        var right = matrix[0].count - 1
        var i = 0
        var j = 0
        var array = [Int]()
        while count > 0 {
            while i <= right {
                array.append(matrix[top][i])
                i += 1
                count -= 1
            }
            i -= 1
            top += 1
            j += 1
            if count == 0 {
                break
            }

            while j <= bottom {
                array.append(matrix[j][right])
                j += 1
                count -= 1
            }
            j -= 1
            right -= 1
            i -= 1
            if count == 0 {
                break
            }

            while i >= left {
                array.append(matrix[bottom][i])
                i -= 1
                count -= 1
            }
            i += 1
            bottom -= 1
            j -= 1
            if count == 0 {
                break
            }

            while j >= top {
                array.append(matrix[j][left])
                j -= 1
                count -= 1
            }
            j += 1
            left += 1
            i += 1
            if count == 0 {
                break
            }
        }

        return array
    }

    
    func method(n: Int) -> [[Int]] {
        var array = Array(repeating: Array(repeating: 0, count: n), count: n)
        
        var top = 0
        var left = 0
        var bottom = n - 1
        var right = n - 1
        var num = 1
        while num <= (n * n) {
            
            for i in left..<(right + 1) {
                array[top][i] = num
                num += 1
            }
            if !checkNum(n: n, num: num) {
                return array
            }
            top += 1
            
            for i in top..<(bottom + 1) {
                array[i][right] = num
                num += 1
            }
            if !checkNum(n: n, num: num) {
                return array
            }
            right -= 1
            
            for i in (left..<(right + 1)).reversed() {
                array[bottom][i] = num
                num += 1
            }
            if !checkNum(n:n, num: num) {
                return array
            }
            bottom -= 1
            
            for i in (top..<(bottom + 1)).reversed() {
                array[i][left] = num
                num += 1
            }
            if !checkNum(n: n, num: num) {
                return array
            }
            left += 1
            
        }

        return array
    }
    
    func checkNum(n: Int,num: Int) -> Bool {
        if num > (n * n) {
            return false
        }
        return true
    }
    
    
    
    
    //=================接雨水=======================
    
    
    func trap(_ height: [Int]) -> Int {
        var array = height
        var max = 0
        var isOver = false
        while !isOver {
            var begin = -1
            var end = -1
            var black = 0
            for i in 0..<array.count {
                let num = array[i]
                if num > 0 {
                    array[i] = num - 1
                    if begin < 0 {
                        begin = i
                    }
                    end = i
                    black += 1
                }
            }
            if begin == end {
                isOver = true
            } else {
                max += (end - begin - black + 1)
            }
            black = 0
        }
        return max
    }
    
    
    
    //=============最长回文子串==================
    func longestPalindrome(_ s: String) -> String {
        guard s.count > 1 else {
            return s
        }
        var max = 0
        var maxI = 0
        var maxJ = 0
        
        let array = Array(s)

        for i in 0..<array.count {
            for j in (0..<array.count).reversed() {
                if array[i] == array[j] {
                    //
                    if isPalind(array: array, i: i, j: j), j - i > max {
                        max = j - i
                        maxI = i
                        maxJ = j
                    }
                }
            }
        }
        
        return String(s[s.index(s.startIndex, offsetBy: maxI)...s.index(s.startIndex, offsetBy: maxJ)])
    }
    
    func isPalind(array: [String.Element], i: Int, j: Int) -> Bool {
        var i = i
        var j = j
        // j-1 >= i+1
        while j - i >= 2 {
            i += 1
            j -= 1
            if array[i] != array[j] {
                return false
            }
        }
        
        return true
    }
    

//==============汉诺塔===================
    
    func hanota(_ A: inout [Int], _ B: inout [Int], _ C: inout [Int]) {
        guard A.count > 0 else {
            return
        }
        if A.count == 1 {
            C.append(A.first!)
            A.remove(at: 0)
            B.removeAll()
            
        } else {
            C.append(A.first!)
            A.remove(at: 0)
            B = A
            hanota(&B, &A, &C)
        }
    }
    
//==================拼车====================
    
    func carPooling(_ trips: [[Int]], _ capacity: Int) -> Bool {
        var sum = capacity
        var array = Array.init(repeating: 0, count: 1001)
        
        for trip in trips {
            let num = trip[0]
            let start = trip[1]
            let end = trip[2]
            array[start] += num
            array[end] -= num
        }
        
        for i in 0..<array.count {
            sum -= array[i]
            if sum < 0 {
                return false
            }
        }
        return true
    }
    
//==================岛屿算法====================
    
    func numIslands(_ grid: [[Character]]) -> Int {
        guard grid.count > 0, grid[0].count > 0 else {
            return 0
        }
        var grid = grid
        var count = 0
        for i in 0..<grid.count {
            for j in 0..<grid[0].count {
                if grid[i][j] == "1" {
                    numDFS(grid: &grid, row: i, colum: j)
                    count += 1
                }
            }
        }
        return count
    }
    
    func numDFS(grid: inout [[Character]], row: Int, colum: Int) {
        guard row < grid.count, row >= 0, colum < grid[0].count, colum >= 0, grid[row][colum] == "1" else {
            return
        }
        
        grid[row][colum] = "0"
        
        numDFS(grid: &grid, row: row - 1, colum: colum)
        numDFS(grid: &grid, row: row + 1, colum: colum)
        numDFS(grid: &grid, row: row, colum: colum - 1)
        numDFS(grid: &grid, row: row, colum: colum + 1)
    }
    
//===============千分位==================
    func thousandSeparator(_ n: Int) -> String {
        var n = n
        var numStr = ""
        if n > 1000 {
            while n > 1000 {
                let num = n % 1000
                let sp = (numStr.count > 0) ? "." : ""
                numStr = String(format: "%03d", num) + sp + numStr
                n = n / 1000
            }
            numStr = String(n) + "." + numStr
        } else {
            numStr = String(n)
        }
        return numStr
    }

//=================平方数之和====================
    //给定一个非负整数 c ，你要判断是否存在两个整数 a 和 b，使得 a2 + b2 = c 。
    func judgeSquareSum(_ c: Int) -> Bool {
        var row = 0
        var column = Int(sqrt(Double(c)))
        
        while row <= column {
            let num = row * row + column * column
            if num == c {
                return true
            } else if num > c {
                column -= 1
            } else {
                row += 1
            }
        }
        return false
    }


    
}

