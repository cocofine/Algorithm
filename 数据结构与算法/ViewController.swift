//
//  ViewController.swift
//  数据结构与算法
//
//  Created by ouyangqi on 2022/12/18.
//

import UIKit


class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let btn = UIButton.init(frame: CGRect(x: 200, y: 200, width: 100, height: 50))
        btn.setTitle("入口", for: .normal)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        btn.backgroundColor = .cyan
        view.addSubview(btn)
        

    }


    
    @objc func btnAction() {
//        let vc = LinkedController()
        let vc = ClassicController()
//        let vc = TreeController()
//        let vc = DichotomyController()
//        let vc = SortViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

