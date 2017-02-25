//
//  CMViewControllerFir.swift
//  展开Cell的三种方式
//
//  Created by CM on 2017/2/25.
//  Copyright © 2017年 CM. All rights reserved.
//

import UIKit

class CMViewControllerFir: UIViewController {

    var tableViewFir: UITableView?
    
    // 是否展开
    var isExpand = false
    // 展开 Cell的下标
    var selectedIndexPath: IndexPath?
    let cellCount = 5
    let expandCount = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewFir = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: UITableViewStyle.grouped)
        tableViewFir?.delegate = self
        tableViewFir?.dataSource = self
        self.view.addSubview(tableViewFir!)
        
        tableViewFir?.register(CustomCell.classForCoder(), forCellReuseIdentifier: "CustomCell")
        tableViewFir?.register(ExpansionCell.classForCoder(), forCellReuseIdentifier: "ExpansionCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension CMViewControllerFir: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isExpand {
            return cellCount + expandCount
        }
        
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if self.isExpand && self.selectedIndexPath!.row
            < indexPath.row && indexPath.row
            <= self.selectedIndexPath!.row + expandCount {
            cell = tableView.dequeueReusableCell(withIdentifier: "ExpansionCell", for: indexPath)
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectedIndexPath == nil {
            self.isExpand = true
            self.selectedIndexPath = indexPath
            
            
            /**
              1.做UITableView的修改，删除，选择时，需要对UITableView进行一系列的动作操作
              2.允许多个插入/删除的行和部分动画同时。可嵌套的
              3.需要使用beginUpdates方法和endUpdates方法，将要做的删除操作“包”起来
               分别代表动画的开始开始和结束。
               两者成对出现，可以嵌套使用。
               一般，在添加，删除，选择 tableView中使用，并实现动画效果。
               在动画块内，不建议使用reloadData方法，如果使用，会影响动画
             */
            self.tableViewFir?.beginUpdates()
            self.tableViewFir?.insertRows(at: self.indexPathsForExpandRow(row: indexPath.row), with: .top)
            self.tableViewFir?.endUpdates()     
            
        } else {
            if self.isExpand {
                if self.selectedIndexPath == indexPath {
                    self.isExpand = false
                    self.isExpand = false
                    self.tableViewFir?.beginUpdates()
                    self.tableViewFir?.deleteRows(at: self.indexPathsForExpandRow(row: self.selectedIndexPath!.row), with: .top)
                    self.tableViewFir?.endUpdates()
                    self.selectedIndexPath = nil
                } else if self.selectedIndexPath!.row < indexPath.row && indexPath.row <= self.selectedIndexPath!.row + expandCount {
                    print("点击展开的 cell")
                    
                } else {
                    self.isExpand = false
                    self.tableViewFir?.beginUpdates()
                    self.tableViewFir?.deleteRows(at: self.indexPathsForExpandRow(row: self.selectedIndexPath!.row), with: .top)
                    self.tableViewFir?.endUpdates()
                    self.selectedIndexPath = nil
        
                }
            }
            
        }
    }
    
    func indexPathsForExpandRow(row: Int) -> Array<IndexPath> {
        var indexPaths = Array<IndexPath>()
        
        for i in 1...expandCount {
            let idxPath = IndexPath.init(row: row + i, section: 0)
            
            indexPaths.append(idxPath)
        }
        
        return indexPaths
        
    }
    
    
}








