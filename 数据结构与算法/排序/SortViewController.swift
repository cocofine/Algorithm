//
//  SortViewController.swift
//  数据结构与算法
//
//  Created by ouyangqi on 2023/1/11.
//

import UIKit

class SortViewController: UIViewController {
    
    var array = [5, 3, 6, 9, 8, 6, 7, 2, 4, 6, 3]
//    var array = [1, 2, 5, 9, 4, 3, 6]

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        print("array = \(array)")
//        //冒泡
//        let array1 = self.bubbleSort(array: array)
//        print("array1 = \(array1)")
//        //升级冒泡
//        let array2 = self.bubbleSort2(array: array)
//        print("array2 = \(array2)")
//        //选择排序
//        let array3 = self.selectionSort(array: array)
//        print("array3 = \(array3)")
//        //插入排序
//        let array4 = self.insertionSort(array: array)
//        print("array4 = \(array4)")
        //快速排序
//            self.speedSort(begin: 0, end: array.count)
        
//            print("array5 = \(array)")
//            print(array)
//            print(findKthLargest([3,2,1,5,6,4], 2))
//            print(array)


//        int[] arr01 = {5, 3, 6, 9, 8, 6, 7, 2, 4, 6, 3};

        buildBinaryHeap();
        
    }






    //冒泡排序
    func bubbleSort(array: [Int]) -> [Int] {
        var array = array
        for j in 0..<array.count {
            for i in 1..<array.count - j {
                if array[i] < array[i-1] {
                    let temp = array[i]
                    array[i] = array[i-1]
                    array[i-1] = temp
                }
            }
        }
        return array
    }
    
    //升级冒泡排序
    func bubbleSort2(array: [Int]) -> [Int] {
        var array = array
        for _ in 0..<array.count {
            var endIndex = 0
            var flag = true
            for i in 1..<array.count - endIndex {
                if array[i] < array[i-1] {
                    let temp = array[i]
                    array[i] = array[i-1]
                    array[i-1] = temp
                    endIndex = i
                    flag = false
                }
            }
            if flag {
                break
            }
        }
        return array
    }
    
    //选择排序
    func selectionSort(array: [Int]) -> [Int] {
        var array = array
        for j in 0..<array.count {
            var min = j
            for i in j..<array.count {
                if array[i] <= array[min] {
                    min = i
                }
            }
            let temp = array[j]
            array[j] = array[min]
            array[min] = temp
        }
        return array
    }
    
    //插入排序
    func insertionSort(array: [Int]) -> [Int] {
        var array = array
        for j in 1..<array.count {
            for i in 0..<j {
                if array[j - i - 1] > array[j - i] {
                    let temp = array[j - i]
                    array[j - i] = array[j - i - 1]
                    array[j - i - 1] = temp
                }
            }
        }
        return array
    }
    
    //快速排序
//    func speedSort(begin: Int, end: Int) {
//        if end - begin < 2 {
//            return
//        }
//
//        let mid = midIndex(begin: begin, end: end)
//        speedSort(begin: begin, end: mid)
//        speedSort(begin: mid + 1, end: end)
//    }

//    func midIndex(begin: Int, end: Int) -> Int {
//        var begin = begin
//        var end = end
//        let value = array[begin]
//        end -= 1
//
//        while begin < end {
//
//            while begin < end {
//                if array[end] > value {
//                    end -= 1
//                } else {
//                    array[begin] = array[end]
//                    begin += 1
//                    break
//                }
//            }
//
//            while begin < end {
//                if array[begin] < value {
//                    begin += 1
//                } else {
//                    array[end] = array[begin]
//                    end -= 1
//                    break
//                }
//            }
//        }
//
//        array[begin] = value
//
//        return begin
//    }
//    var array = [Int]()
//        var k = 0
//        func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
//            array = nums
//            self.k = k
//            speedSort(0, nums.count - 1)
//            return array[nums.count - k]
//        }
//
//        func speedSort(_ begin: Int, _ end: Int) {
//            guard end - begin > 0 else { return }
//            let mid = randimMid(begin, end)
//            if mid == (array.count - k) {
//                return
//            } else if mid > (array.count - k) {
//                speedSort(begin, mid - 1)
//            } else {
//                speedSort(mid + 1, end)
//            }
//        }
//
//        func randimMid(_ begin: Int, _ end: Int) -> Int {
//            let temp = array[end]
//            var i = begin
//            for j in begin..<end {
//                if array[j] < temp {
//                    array.swapAt(i, j)
//                    i += 1
//                }
//            }
//            array.swapAt(i, end)
//            return i
//        }


    
}


//二叉堆
extension SortViewController {
    
    //上浮
    func upAdjust() {
        var childIdx = array.count - 1
        var parentIdx = (childIdx - 1) / 2
        let temp = array[childIdx]
        while childIdx > 0, temp > array[parentIdx] {
            array[childIdx] = array[parentIdx]
            childIdx = parentIdx
            parentIdx = (childIdx - 1) / 2
        }
        array[childIdx] = temp
    }
    
    //下沉
    func downAdjust(index: Int) {
        var parentIdx = index
        var childIdx = parentIdx * 2 + 1
        let temp = array[parentIdx]
        while childIdx <= array.count - 1 {
            if childIdx + 1 <= array.count - 1, array[childIdx + 1] > array[childIdx] {
                childIdx += 1
            }
            if temp >= array[childIdx] {
                break
            }
            array[parentIdx] = array[childIdx]
            parentIdx = childIdx
            childIdx = childIdx * 2 + 1
        }
        array[parentIdx] = temp
    }
    
    //构建二叉堆
    func buildBinaryHeap() {
        for i in (0...array.count / 2 - 1).reversed() {
            downAdjust(index: i)
        }
    }
    
    
    
    
    
}
