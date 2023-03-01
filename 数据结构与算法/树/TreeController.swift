//
//  TreeController.swift
//  数据结构与算法
//
//  Created by ouyangqi on 2022/12/21.
//

import UIKit

class TreeController: UIViewController {
    
    var preArray = [Int]()
    var inorderDic = [Int: Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
                    1
            2               3
         4      5       6       7
         
         */


        let head = TreeNode.init(val: 1)
        let node1 = TreeNode.init(val: 2)
        let node2 = TreeNode.init(val: 2)
        let node3 = TreeNode.init(val: 3)
        let node4 = TreeNode.init(val: 4)
        let node5 = TreeNode.init(val: 4)
        let node6 = TreeNode.init(val: 3)
        head.left = node1
        head.right = node2
        node1.left = node3
        node1.right = node4
        node2.left = node5
        node2.right = node6
        

        
//        print(preorderTraversalRecursion(head))
//        print(inorderTraversalRecursion(head))
//        print(postorderTraversalRecursion(head))
//        print(levelOrder(head))
//        print(preorderTraversalIteration(head))
//        print(inorderTraversalIteration(head))
//        print(postorderTraversalIteration(head))
        
//        preorder = [3,9,20,15,7], inorder = [9,3,15,20,7]
//        let n = buildTree([3,9,20,15,7], [9,3,15,20,7])
//       in  [9,3,15,20,7]   po [9,15,7,20,3]
//        let n = buildTree2([9,3,15,20,7], [9,15,7,20,3])
//        print(levelOrder(n))
        
//        print(maxDepth(head))
//        print(isBalanced(head))
//        print(isSymmetric(head))
        
        print(pathSum(head, 6))
    }
    
    //=====================二叉树展开为链表========================
    func flatten(_ root: TreeNode<Int>?) {
        var root = root
        while root != nil {
            if root?.left == nil {
                root = root?.right
            } else {
                var temp = root?.left
                while temp?.right != nil {
                    temp = temp?.right
                }
                temp?.right = root?.right
                root?.right = root?.left
                root?.left = nil
            }
        }
    }
    
    //===================有序数组转二叉树====================
    //输入：nums = [-10,-3,0,5,9]
    //输出：[0,-3,9,-10,null,5]
    //解释：[0,-10,5,null,-3,null,9] 也将被视为正确答案：
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode<Int>? {
        let node = findCenter(nums, 0, nums.count - 1)
        return node
    }

    func findCenter(_ nums: [Int], _ left: Int, _ right: Int) -> TreeNode<Int>? {
        guard left <= right else { return nil }
        let mid = left + (right - left) / 2
        let node = TreeNode(val: nums[mid])
        node.left = findCenter(nums, left, mid - 1)
        node.right = findCenter(nums, mid + 1, right)
        return node
    }
    
    //===================路径总和====================
    var sumArray = [[Int]]()
    func pathSum(_ root: TreeNode<Int>?, _ targetSum: Int) -> [[Int]] {
        let arr = [Int]()
        let sum = targetSum
        findSum(root, arr, sum)
        return sumArray
    }

    func findSum(_ root: TreeNode<Int>?, _ arr: [Int], _ sum: Int) {
        if root == nil {
            return
        }
        var arr = arr
        var sum = sum
        arr.append(root!.val)
        sum -= root!.val
        if root?.left == nil, root?.right == nil {
            if sum == 0 {
                sumArray.append(arr)
            }
            return
        }
        findSum(root?.left, arr, sum)
        findSum(root?.right, arr, sum)
    }
    
    //===================翻转二叉树====================
    func invertTree(_ root: TreeNode<Int>?) -> TreeNode<Int>? {
        guard let root = root else { return root }
        var array = [TreeNode<Int>]()
        array.append(root)
        while array.count > 0 {
            let node = array.removeFirst()
            
            if let left = node.left {
                array.append(left)
            }
            if let right = node.right {
                array.append(right)
            }
            let temp = node.left
            node.left = node.right
            node.right = temp
        }
        return root
    }
    
    //===================对称二叉树====================
    func isSymmetric(_ root: TreeNode<Int>?) -> Bool {
        guard let root = root else { return true }
        if root.left == nil, root.right == nil {
            return true
        }
        var array = [TreeNode<Int>?]()
        array.append(root.left)
        array.append(root.right)
        while array.count > 0 {
            let leftNode = array.removeLast()
            let rightNode = array.removeLast()
            if leftNode == nil, rightNode == nil {
                continue
            } else if leftNode == nil || rightNode == nil {
                return false
            } else if (leftNode?.val ?? 0) != (rightNode?.val ?? 0) {
                return false
            }
            array.append(leftNode?.left)
            array.append(rightNode?.right)
            array.append(leftNode?.right)
            array.append(rightNode?.left)
        }
        return true
    }
    

    
    //===================二叉树深度====================
    func maxDepth(_ root: TreeNode<Int>?) -> Int {
        guard let root = root else { return 0 }
        var queue = [TreeNode<Int>]()
        queue.append(root)
        var num = 0
        while queue.count > 0 {
            var temp = [TreeNode<Int>]()
            for node in queue {
                if let left = node.left {
                    temp.append(left)
                }
                if let right = node.right {
                    temp.append(right)
                }
            }
            queue.removeAll()
            queue = temp
            num += 1
        }
        return num
    }
    
    //递归
    func maxDepth2(_ root: TreeNode<Int>?) -> Int {
        guard let root = root else { return 0 }
        let left = maxDepth(root.left)
        let right = maxDepth(root.right)
        return max(left, right) + 1
    }
    
    //===================平衡二叉树====================
    func isBalanced(_ root: TreeNode<Int>?) -> Bool {
        guard let root = root else { return true }        
        return findHeight(root) != -1
    }
    
    func findHeight(_ root: TreeNode<Int>?) -> Int {
        guard let root = root else { return 0 }
        let left = findHeight(root.left)
        if left == -1 { return -1 }
        let right = findHeight(root.right)
        if right == -1 { return -1 }
        return abs(left - right) < 2 ? max(left, right) + 1 : -1
    }
    
}

//重构二叉树
extension TreeController {
    //===================前序+中续，重构二叉树===============
        func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode<Int>? {
            self.preArray = preorder
            for (i, val) in inorder.enumerated() {
                self.inorderDic[val] = i
            }
            return recur(root: 0, left: 0, right: inorder.count - 1)
        }
        
        func recur(root: Int, left: Int, right: Int) -> TreeNode<Int>? {
            guard left <= right else {return nil}
            let node = TreeNode(val: preArray[root])
            let index = inorderDic[node.val]!
            node.left = recur(root: root + 1, left: left, right: index - 1)
            node.right = recur(root: root + index - left + 1, left: index + 1, right: right)
            return node
        }
        
    //===================中序+后续，重构二叉树===============
        func buildTree2(_ inorder: [Int], _ postorder: [Int]) -> TreeNode<Int>? {
            self.preArray = postorder
            for (i, val) in inorder.enumerated() {
                self.inorderDic[val] = i
            }
            return recur2(root: inorder.count - 1, left: 0, right: inorder.count - 1)
        }
        

        func recur2(root: Int, left: Int, right: Int) -> TreeNode<Int>? {
            guard left <= right else {return nil}
            let node = TreeNode(val: preArray[root])
            let index = inorderDic[node.val]!
            node.left = recur2(root: root - right + index - 1, left: left, right: index - 1)
            node.right = recur2(root: root - 1, left: index + 1, right: right)
            return node
        }

}


//遍历
extension TreeController {
    
    //递归前序遍历    (1, 2, 4, 5, 3, 6, 7)
    func preorderTraversalRecursion(_ root: TreeNode<Int>?) -> [Int] {
        guard let root = root else {return []}
        var array = [Int]()
        array.append(root.val)
        array += preorderTraversalRecursion(root.left)
        array += preorderTraversalRecursion(root.right)
        return array
    }

    //递归中序遍历    (4, 2, 5, 1, 6, 3, 7)
    func inorderTraversalRecursion(_ root: TreeNode<Int>?) -> [Int] {
        guard let root = root else {return []}
        var array = [Int]()
        array += inorderTraversalRecursion(root.left)
        array.append(root.val)
        array += inorderTraversalRecursion(root.right)
        return array
    }
    
    //递归后序遍历    (4, 5, 2, 6, 7, 3, 1)
    func postorderTraversalRecursion(_ root: TreeNode<Int>?) -> [Int] {
        guard let root = root else {return []}
        var array = [Int]()
        array += postorderTraversalRecursion(root.left)
        array += postorderTraversalRecursion(root.right)
        array.append(root.val)
        return array
    }
    
    //层序遍历 (1, 2, 3, 4, 5, 6, 7)
    func levelOrder(_ root: TreeNode<Int>?) -> [Int] {
        guard let root = root else {return []}
        var array = [Int]()
        var queue = [TreeNode<Int>]()
        queue.append(root)
        
        while queue.count > 0 {
            if let node = queue.first {
                array.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            queue.removeFirst()
        }
        return array
    }

    //迭代前序遍历
    func preorderTraversalIteration(_ root: TreeNode<Int>?) -> [Int] {
        guard let root = root else {return []}
        var array = [Int]()
        var stack = [TreeNode<Int>]()
        stack.append(root)
        while stack.count > 0 {
            if let node = stack.last {
                stack.removeLast()
                array.append(node.val)
                if let right = node.right {
                    stack.append(right)
                }
                if let left = node.left {
                    stack.append(left)
                }
            }
        }
        return array
    }
    
    //迭代中序遍历
    func inorderTraversalIteration(_ root: TreeNode<Int>?) -> [Int] {
        guard let root = root else {return []}
        var array = [Int]()
        var stack = [TreeNode<Int>]()
        var cur: TreeNode<Int>? = root
        while stack.count > 0 || cur != nil {
            while cur != nil {
                stack.append(cur!)
                cur = cur?.left
            }
            let node = stack.removeLast()
            array.append(node.val)
            cur = node.right
        }
        return array
    }

    //迭代后序遍历
    func postorderTraversalIteration(_ root: TreeNode<Int>?) -> [Int] {
        guard let root = root else {return []}
        var array = [Int]()
        var stack = [TreeNode<Int>]()
        stack.append(root)
        while stack.count > 0 {
            if let node = stack.last {
                stack.removeLast()
                array.append(node.val)
                if let right = node.left {
                    stack.append(right)
                }
                if let left = node.right {
                    stack.append(left)
                }
            }
        }
        return array.reversed()
    }
    
    
    
}
