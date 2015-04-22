//
//  ChoosingController.swift
//  iKGK
//
//  Created by Matouš Hýbl on 19/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit
import Realm

class ChoosingController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    let realm = RLMRealm.defaultRealm()
    let segmentedControl = UISegmentedControl(items: ["Classes", "Teachers"])
    let cellIdentifier = "Cell"
    
    var classes = [ClassModel]()
    var teachers = [TeacherModel]()
    
    override func loadView() {
        super.loadView()
        loadData()
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(ChooserTableCell.self, forCellReuseIdentifier: cellIdentifier)
        
        segmentedControl.tintColor = UIColor.whiteColor()
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "segmentedControlChanged", forControlEvents: .ValueChanged)
        
        navigationItem.titleView = segmentedControl
        navigationItem.hidesBackButton = true
    }
    
    func loadData() {
        for aClass in ClassModel.allObjects() {
            classes.append(aClass as! ClassModel)
        }
        for teacher in TeacherModel.allObjects() {
            teachers.append(teacher as! TeacherModel)
        }
    }
    
    func segmentedControlChanged() {
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! ChooserTableCell
        if(segmentedControl.selectedSegmentIndex == 0) {
            cell.title = classes[indexPath.row].name
        } else {
            cell.title = teachers[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        Preferences.teacherMode = segmentedControl.selectedSegmentIndex == 1
        Preferences.id = segmentedControl.selectedSegmentIndex == 0 ? classes[indexPath.row].id : teachers[indexPath.row].id
        navigationController?.pushViewController(MainController(), animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(segmentedControl.selectedSegmentIndex == 0) {
            return Int(classes.count)
        } else {
            return Int(teachers.count)
        }
    }
}
