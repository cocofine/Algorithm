//
//  DynamicController.swift
//  数据结构与算法
//
//  Created by ouyangqi on 2022/12/21.
//

import UIKit

class DynamicController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(fibonacciRecursion(n: 9))
        print(fibonacciIteration(n: 9))

        print(frogIteration(n: 8))
        print(frogRecursion(n: 8))
        
        print(changes(coins: [2, 3, 5], amount: 11))

    }
    
    

    
///==============================斐波那契数列=================================
///数列：1、1、2、3、5、8、13、21、34......  写一个函数，输入 n ，求斐波那契数列的第 n 项
/// F(0) = 0,   F(1) = 1
/// F(N) = F(N - 1) + F(N - 2), 其中 N > 1.
    
    //递归法, 复杂度O(2^n)
    func fibonacciRecursion(n: Int) -> Int {
        if n == 1 {
            return 1
        } else if n == 2 {
            return 1
        } else {
            return fibonacciRecursion(n: n - 1) + fibonacciRecursion(n: n - 2)
        }
    }
    
    //迭代法, 复杂度O(n)
    func fibonacciIteration(n: Int) -> Int {
        if n == 1 {
            return 1
        } else if n == 2 {
            return 1
        }
        var f = 1       //f(1)
        var sum = 1     //f(2)
        for _ in 3...n {
            sum = sum + f   //求和       F(N) = F(N - 1) + F(N - 2)
            f = sum - f     //求前一项    F(N - 1) = F(N) - F(N - 2)
        }
        return sum
    }
    
    
    
///==============================青蛙跳台阶=================================
///一只青蛙一次可以跳上1级台阶，也可以跳上2级。求该青蛙跳上一个n级的台阶总共有多少种跳法。
///n=1, (1)                                                                1种
///n=2, (1,1) (2)                                                        2种
///n=3, (1,1,1) (1,2) (2,1)                                          3种
///n=4, (1,1,1,1) (1,1,2) (1,2,1) (2,1,1) (2,2)             5种
///数列： 1, 2 , 3, 5, 8, 13, 21, 34, 55
/// F(N) = F(N - 1) + F(N - 2)
    
    //递归
    func frogRecursion(n: Int) -> Int {
        if n == 1 {
            return 1
        } else if n == 2 {
            return 2
        } else {
            return frogRecursion(n: n - 1) + frogRecursion(n: n - 2)
        }
    }
    
    //迭代法
    func frogIteration(n: Int) -> Int {
        if n == 1 {
            return 1
        } else if n == 2 {
            return 2
        }
        var f = 1       //f(1)
        var sum = 2     //f(2)
        for _ in 3...n {
            sum = sum + f
            f = sum - f
        }
        return sum
    }


    
    
    
///==============================零钱兑换=================================
/// 给你一个整数数组 coins ，表示不同面额的硬币；以及一个整数 amount ，表示总金额。
/// 计算并返回可以凑成总金额所需的 最少的硬币个数 。如果没有任何一种硬币组合能组成总金额，返回 -1 。
/*
 示例 1：
 输入：coins = [1, 2, 5], amount = 11
 输出：3
 解释：11 = 5 + 5 + 1
 
 示例 2：
 输入：coins = [2], amount = 3
 输出：-1
 
 示例 3：
 输入：coins = [1], amount = 0
 输出：0
 */
///思路（如示例1）:
/*
 当我们要凑出价值为w=11的硬币，首先面临3种情况
 1）当我们取了价值为1的硬币，将面临凑出价值为10的情况
 2）当我们取了价值为2的硬币，将面临凑出价值为9的情况
 3）当我们取了价值为5的硬币，将面临凑出价值为6的情况
  记凑出价值为n所需要的最少硬币数为f(n)
 
 f      最优解     1           2           5
 f(0)   0         -           -           -
 f(1)   1      1+f(0)=1       -           -
 f(2)   1      1+f(1)=2    1+f(0)=1       -
 f(3)   2      1+f(2)=2    1+f(1)=2       -
 f(4)   2      1+f(3)=3    1+f(2)=2       -
 f(5)   1      1+f(4)=3    1+f(3)=3    1+f(0)=1
 f(6)   2      1+f(5)=2    1+f(4)=3    1+f(1)=2
 f(7)   2      1+f(6)=3    1+f(5)=2    1+f(2)=2
 f(8)   3      1+f(7)=3    1+f(6)=3    1+f(3)=3
 f(9)   3      1+f(8)=4    1+f(7)=3    1+f(4)=3
 f(10)  2      1+f(9)=4    1+f(8)=4    1+f(5)=2
 f(11)  3      1+f(10)=3   1+f(9)=4    1+f(6)=3
 
 则f(n)只与f(n-1)、f(n-2)、f(n-5)有关
 f(n) = min(1+f(n-1), 1+f(n-2), 1+f(n-5))
*/
    
    func changes(coins: [Int], amount: Int) -> Int {
        guard amount > 0 else {
            return 0
        }

        var dp = Array(repeating: amount + 1, count: amount + 1)   //index为剩余零钱数，value为需要最小硬币数
        dp[0] = 0   //当剩余为0时，硬币数为0

        for coin in coins {
            for i in 1...amount {
                if i >= coin {
                    dp[i] = min(dp[i], dp[i-coin]+1)
                }
            }
        }

        return dp[amount] == amount + 1 ? -1 : dp[amount]
    }
    
    
    
/*
 重量      总价值     1(2)          4(3)           3(4)
 0          0       -              -              -
 1          2       2+f(0)         -              -
 2          4       2+f(1)         -              -
 3          6       2+f(2)         -             4+f(0)
 4          8       2+f(3)       3+f(0)          4+f(1)
 5          10      2+f(4)       3+f(1)          4+f(2)
 
 */
    

    

    
}
