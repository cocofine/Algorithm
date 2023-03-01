//
//  TreeNode.swift
//  数据结构与算法
//
//  Created by ouyangqi on 2022/12/21.
//

import UIKit

public class TreeNode<E: Equatable> {
    var val: E
    var left: TreeNode?
    var right: TreeNode?
    public init(val: E) {
        self.val = val
    }
    
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val
    }
}
