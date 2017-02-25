//
//  CMViewControllerThi.swift
//  展开Cell的三种方式
//
//  Created by CM on 2017/2/25.
//  Copyright © 2017年 CM. All rights reserved.
//

import UIKit

class CMViewControllerThi: UIViewController {

    let cellCount = 5
    let expandCount = 3
    
    var tableViewThi: UITableView?
    var isExpand = false
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewThi = UITableView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .grouped)
        tableViewThi?.delegate = self
        tableViewThi?.dataSource = self
        tableViewThi?.register(CustomCell.classForCoder(), forCellReuseIdentifier: "CustomCell")
        isExpand = false
        self.view.addSubview(tableViewThi!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}

extension CMViewControllerThi: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.isExpand && self.selectedIndexPath == indexPath {
            return 121
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectedIndexPath == nil {
            self.isExpand = true
            self.selectedIndexPath = indexPath
            self.tableViewThi?.beginUpdates()
            self.tableViewThi?.reloadRows(at: [indexPath], with: .fade)
            self.tableViewThi?.endUpdates()
        } else {
            if self.isExpand {
                if self.selectedIndexPath == indexPath {
                    self.isExpand = false
                    self.tableViewThi?.beginUpdates()
                    self.tableViewThi?.reloadRows(at: [indexPath], with: .fade)
                    self.tableViewThi?.endUpdates()
                    self.selectedIndexPath = nil
                } else {
                    self.isExpand = false
                    self.tableViewThi?.beginUpdates()
                    self.tableViewThi?.reloadRows(at: [self.selectedIndexPath!], with: .fade)
                    self.tableViewThi?.endUpdates()
                    self.selectedIndexPath = nil
                    
                }
            }
            
        }
    }
    
    
}
