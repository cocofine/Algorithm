//
//  LinkedController.swift
//  数据结构与算法
//
//  Created by ouyangqi on 2022/12/21.
//

import UIKit

class LinkedController: UIViewController {
    
    var head: LinkNode<Int>?

    override func viewDidLoad() {
        super.viewDidLoad()
        let link = SingleLinkedList<Int>.init()
        link.append(atHead: 1)
        link.append(atTail: 2)
        link.append(atTail: 3)
        link.append(atTail: 4)
        link.append(atTail: 5)
        head = link.head
        

        
//        let cache = LRUCache.init(2)
//        cache.put(1, 1)
//        cache.put(2, 2)
//        cache.get(1)
//        cache.put(3, 3)
//        cache.get(2)
//        cache.put(4, 4)
//        cache.get(1)
//        cache.get(3)
//        cache.get(4)
        
//        LRUCache lRUCache = new LRUCache(2);
//        lRUCache.put(1, 1); // 缓存是 {1=1}
//        lRUCache.put(2, 2); // 缓存是 {1=1, 2=2}
//        lRUCache.get(1);    // 返回 1
//        lRUCache.put(3, 3); // 该操作会使得关键字 2 作废，缓存是 {1=1, 3=3}
//        lRUCache.get(2);    // 返回 -1 (未找到)
//        lRUCache.put(4, 4); // 该操作会使得关键字 1 作废，缓存是 {4=4, 3=3}
//        lRUCache.get(1);    // 返回 -1 (未找到)
//        lRUCache.get(3);    // 返回 3
//        lRUCache.get(4);    // 返回 4
//        print(isPalindrome(head))


        
//        getAllNode(node: swapNodes(head, 2))
//        getAllNode(node: reverseBetween(head, 1, 1))
        getAllNode(node: reverseList2(head))
    }

    
    
    // 1->2->3->4->5
    func reverseBetween(_ head: LinkNode<Int>?, _ left: Int, _ right: Int) -> LinkNode<Int>? {
        guard let head = head else {
            return nil
        }
        var count = 0
        let node = LinkNode(val: -1)
        node.next = head
        var cur: LinkNode<Int>? = node
        var start: LinkNode<Int>? = nil
        var end: LinkNode<Int>? = nil
        var pre: LinkNode<Int>? = nil
        while count <= right {
            if count + 1 == left {
                start = cur
                end = cur?.next
                cur = cur?.next
            } else if count == right {
                let temp = cur?.next
                cur?.next = pre
                start?.next = cur
                end?.next = temp
            } else if start != nil {
                let temp = cur?.next
                cur?.next = pre
                pre = cur
                cur = temp
            } else {
                cur = cur?.next
            }
            count += 1
            
        }
        
        return node.next
    }
    
    
    
    
    //找到环中的入口节点
//    a + b
//    a + b + n(b + c) = a + b + nb + nc = a + b(n + 1) + nc
//    a + b(n + 1) + nc = 2(a + b)
//    a + bn + b + nc = 2a + 2b
//    a = n(b + c) - b + c - c
//    a = (n - 1)(b + c) + c
    func detectCycle(_ head: LinkNode<Int>?) -> LinkNode<Int>? {
        guard let head = head, head.next != nil else { return nil }
        var fast: LinkNode<Int>? = head
        var slow: LinkNode<Int>? = head
        repeat {
            fast = fast?.next?.next
            slow = slow?.next
        } while fast !== slow

        fast = head
        while fast !== slow {
            fast = fast?.next
            slow = slow?.next
        }

        return slow
    }
    
    //交换顺数第k和倒数第k的值
    func swapNodes(_ head: LinkNode<Int>?, _ k: Int) -> LinkNode<Int>? {
        guard let head = head, k > 0 else { return head }
        var leftNode: LinkNode<Int>? = nil
        let node = LinkNode<Int>(val: -1)
        node.next = head
        var fast: LinkNode<Int>? = node
        var slow: LinkNode<Int>? = node
        
        var k = k
        while fast?.next != nil {
            fast = fast?.next
            if k == 1 {
                leftNode = fast
            }
            if k <= 0 {
                slow = slow?.next
            }
            k -= 1
        }
        let temp = leftNode?.val ?? 0
        leftNode?.val = slow?.next?.val ?? 0
        slow?.next?.val = temp
        return node.next
    }

    
    
    //打印所有结点
    func getAllNode(node: LinkNode<Int>?) -> [Int] {
        var array = [Int]()
        guard let node = node else {
            return array
        }
        var cur: LinkNode<Int>? = node
        while cur?.next != nil {
            array.append(cur?.val ?? -1)
            cur = cur?.next
        }
        array.append(cur?.val ?? -1)
        print(array)
        return array
    }
    

    
    //回文链表
    func isPalindrome(_ head: LinkNode<Int>?) -> Bool {
        guard head?.next != nil else { return true }
        var fast = head
        var slow = head
        while fast != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }
        fast = head
        var node = reverseList(slow)

        while node != nil {
            if node?.val != fast?.val {
                return false
            }
            node = node?.next
            fast = fast?.next
        }
        return true
    }
    

    
    //输入一个链表，输出该链表中倒数第k个节点。
    //给定一个链表: 1->2->3->4->5, 和 k = 2.
    //返回链表 4->5.
    func getKthFromEnd(_ head: LinkNode<Int>?, _ k: Int) -> LinkNode<Int>? {
        guard let head = head, k > 0 else {return head}
        let node = LinkNode<Int>(val: -1)
        node.next = head
        var slow: LinkNode<Int>? = node
        var fast: LinkNode<Int>? = node
        var k = k
        while k > 0 {
            fast = fast?.next
            k -= 1
        }
        while fast != nil {
            slow = slow?.next
            fast = fast?.next
        }
        return slow
    }
    
    //删除倒数第n个结点
    //输入：head = [1,2,3,4,5], n = 2
    //输出：[1,2,3,5]
    func removeNthFromEnd(_ head: LinkNode<Int>?, _ n: Int) -> LinkNode<Int>? {
        guard let head = head, n > 0 else {return head}
        let node = LinkNode<Int>(val: -1)
        node.next = head
        var k = n + 1
        var slow: LinkNode<Int>? = node
        var fast: LinkNode<Int>? = node
        while k > 0 {
            fast = fast?.next
            k -= 1
        }
        while fast != nil {
            fast = fast?.next
            slow = slow?.next
        }
        slow?.next = slow?.next?.next
        return node.next
    }
    
    //两个链表的第一个重合节点
    func getIntersectionNode(_ headA: LinkNode<Int>?, _ headB: LinkNode<Int>?) -> LinkNode<Int>? {
        var curA: LinkNode<Int>? = headA
        var curB: LinkNode<Int>? = headB
        while curA !== curB {
            if curB == nil, curA == nil { return nil }
            curA = curA == nil ? headB : curA?.next
            curB = curB == nil ? headA : curB?.next
        }
        return curA
    }
    
    //链表中的两数相加
    //  7->2->4->3
    //     5->6->4
    //  7->8->0->7
    func addTwoNumbers(_ l1: LinkNode<Int>?, _ l2: LinkNode<Int>?) -> LinkNode<Int>? {
        var list1: LinkNode<Int>? = reverseList(l1)
        var list2: LinkNode<Int>? = reverseList(l2)
        var bit = 0
        let node = LinkNode<Int>(val: -1)
        var cur: LinkNode<Int>? = node
        while list1 != nil || list2 != nil {
            let sum = (list1?.val ?? 0) + (list2?.val ?? 0) + bit
            bit = sum / 10
            let num = sum % 10
            let n = LinkNode<Int>(val: num)
            cur?.next = n
            cur = cur?.next
            list1 = list1?.next
            list2 = list2?.next
        }
        if bit != 0 {
            let n = LinkNode<Int>(val: bit)
            cur?.next = n
        }
        return reverseList(node.next)
    }

    

    
}

//合并链表
extension LinkedController {
    
    //合并链表
    //输入：1->2->4, 1->3->4
    //输出：1->1->2->3->4->4
    func mergeTwoLists(_ l1: LinkNode<Int>?, _ l2: LinkNode<Int>?) -> LinkNode<Int>? {
        var cur1: LinkNode<Int>? = l1
        var cur2: LinkNode<Int>? = l2
        let node = LinkNode<Int>(val: -1)
        var pre: LinkNode<Int>? = node
        while cur1 != nil, cur2 != nil {
            let val1 = cur1?.val ?? 0
            let val2 = cur2?.val ?? 0
            if val1 < val2 {
                pre?.next = cur1
                cur1 = cur1?.next
            } else {
                pre?.next = cur2
                cur2 = cur2?.next
            }
            pre = pre?.next
        }
        if cur1 == nil {
            pre?.next = cur2
        } else if cur2 == nil {
            pre?.next = cur1
        }
        return node.next
    }
    
    //合并链表递归做法
    func mergeTwoLists2(_ list1: LinkNode<Int>?, _ list2: LinkNode<Int>?) -> LinkNode<Int>? {
        if list1 == nil {
            return list2
        } else if list2 == nil {
            return list1
        } else {
            if (list1?.val ?? 0) < (list2?.val ?? 0) {
                list1?.next = mergeTwoLists2(list1?.next, list2)
                return list1
            } else {
                list2?.next = mergeTwoLists2(list1, list2?.next)
                return list2
            }
        }
    }
    
    //合并多个链表
    func mergeKLists(_ lists: [LinkNode<Int>?]) -> LinkNode<Int>? {
        guard lists.count > 0 else { return nil }
        let head = LinkNode<Int>(val: -1)
        var cur: LinkNode<Int>? = head
        var array = [LinkNode<Int>]()
        for l in lists {
            if let l = l {
                array.append(l)
            }
        }

        while array.count > 0 {
            var minValue = 99999
            var minI = 0
            for (i, value) in array.enumerated() {
                if value.val <= minValue {
                    minValue = value.val
                    minI = i
                }
            }
            
            cur?.next = array[minI]
            cur = cur?.next
            if array[minI].next != nil {
                array[minI] = array[minI].next!
            } else {
                array.remove(at: minI)
            }
            minValue = 0
            minI = 0
        }
        return head.next
    }
    
}

//基础
extension LinkedController {
    
    //链表翻转
    func reverseList(_ head: LinkNode<Int>?) -> LinkNode<Int>? {
        var cur: LinkNode<Int>? = head
        var pre: LinkNode<Int>? = nil
        while cur != nil {
            let temp = cur?.next
            cur?.next = pre
            pre = cur
            cur = temp
        }
        return pre
    }
    
    //1->2->3->4->5
    func reverseList2(_ head: LinkNode<Int>?) -> LinkNode<Int>? {
//        * 明确递归的终止条件
//        * 提取重复的逻辑，缩小问题的规模不断递去
//        * 给出递归终止时的处理办法
        
        
        
//        if head?.next?.next == nil {
//            let temp = head?.next
//            temp?.next = head
//            return temp
//        } else {
//            let node = reverseList2(head?.next)
//            let temp = node?.next
//            node?.next = temp
//
//        }
        
        if head?.next == nil || head == nil {
            return head
        }
        
        let node = reverseList2(head?.next)
        head?.next?.next = head
        head?.next = nil
        return node
    }
    
    
    
    //找中间节点，快慢指针
    func middleNode(_ head: LinkNode<Int>?) -> LinkNode<Int>? {
        var fast = head
        var slow = head
        while fast != nil, fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }
        return slow
    }
    
}

//LRU 淘汰算法 （双向链表 + map）
extension LinkedController {
    
    class Node: NSObject {
        var pre: Node?
        var next: Node?
        var key = 0
        var value = 0
        
        init(key: Int, value: Int) {
            self.value = value
            self.key = key
        }
        
    }
    
    
    class LRUCache {

        var capacity = 0
        var head = Node.init(key: 0, value: 0)
        var end = Node.init(key: 0, value: 0)
        var map = [Int: Node]()
        

        init(_ capacity: Int) {
            self.capacity = capacity
            head.next = end
            end.pre = head
        }
        
        func get(_ key: Int) -> Int {
            guard let node = map[key] else { return -1 }
            removeNode(node: node)
            addNode(node: node)
            return node.value
        }
        
        func put(_ key: Int, _ value: Int) {
            if let node = map[key] {
                node.value = value
                removeNode(node: node)
                addNode(node: node)
            } else {
                if capacity == map.count {
                    let last = end.pre!
                    map.removeValue(forKey: last.key)
                    removeNode(node: last)
                }
                let node = Node.init(key: key, value: value)
                map[key] = node
                addNode(node: node)
            }
        }
        
        func addNode(node: Node) {
            head.next?.pre = node
            node.next = head.next
            node.pre = head
            head.next = node
        }
        
        func removeNode(node: Node) {
            node.next?.pre = node.pre
            node.pre?.next = node.next
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
