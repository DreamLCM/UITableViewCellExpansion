//
//  CMViewControllerSec.swift
//  展开Cell的三种方式
//
//  Created by CM on 2017/2/25.
//  Copyright © 2017年 CM. All rights reserved.
//

import UIKit

class CMViewControllerSec: UIViewController {

    var tableViewSec: UITableView?
    
    let sectionCount = 5
    let expandCount = 3
    
    var isExpand = false
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSec = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .grouped)
        tableViewSec?.delegate = self
        tableViewSec?.dataSource = self
        tableViewSec?.separatorStyle = .none
        self.view.addSubview(tableViewSec!)
        
        tableViewSec?.register(CustomCell.classForCoder(), forCellReuseIdentifier: "CustomCell")
        tableViewSec?.register(ExpansionCell.classForCoder(), forCellReuseIdentifier: "ExpansionCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

extension CMViewControllerSec: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.isExpand && self.selectedIndexPath?.section == section {
            return 1 + expandCount
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if self.isExpand && self.selectedIndexPath!.section == indexPath.section {
            cell = tableView.dequeueReusableCell(withIdentifier: "ExpansionCell", for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.isExpand && self.selectedIndexPath?.section
            == indexPath.section && indexPath.row != 0 {
            return 77
        } else {
            return 44
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectedIndexPath == nil {
            self.isExpand = true
            self.selectedIndexPath = indexPath
            tableView.beginUpdates()
            tableView.insertRows(at: indexPathsForExpandSection(section: indexPath.section), with: .top)
            tableView.endUpdates()
            
        } else {
            if self.isExpand {
                if self.selectedIndexPath == indexPath {
                    self.isExpand = false
                    tableView.beginUpdates()
                    tableView.deleteRows(at: indexPathsForExpandSection(section: indexPath.section), with: .top)
                    tableView.endUpdates()
                    self.selectedIndexPath = nil
                } else if self.selectedIndexPath?.row != indexPath.row && indexPath.section <= self.selectedIndexPath!.section  {
                    
                    
                } else {
                    self.isExpand = false
                    tableView.beginUpdates()
                    tableView.deleteRows(at: indexPathsForExpandSection(section: self.selectedIndexPath!.section), with: .top)
                    tableView.endUpdates()
                    self.selectedIndexPath = nil
                }
            }
        }
    }
    
    
    
    
    func indexPathsForExpandSection(section: Int) -> Array<IndexPath> {
        var indexPaths = Array<IndexPath>()
        
        for i in 1...expandCount {
            let idxPath = IndexPath(row: i, section: section)
            
            indexPaths.append(idxPath)
        }
        
        return indexPaths
        
    }

    
}
