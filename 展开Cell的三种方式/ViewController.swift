//
//  ViewController.swift
//  展开Cell的三种方式
//
//  Created by CM on 2017/2/25.
//  Copyright © 2017年 CM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func handlePressButton(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            print("插入新的 Cell")
            let vc = CMViewControllerFir()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            print("用 Section 展开的Cell的数量")
            let vc = CMViewControllerSec()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            let vc = CMViewControllerThi()
            self.navigationController?.pushViewController(vc, animated: true)
            print("更改 Cell的高度")
            break
        default:
            break
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    
}


