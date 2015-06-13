//
//  ChoosingController.swift
//  iKGK
//
//  Created by Matouš Hýbl on 19/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit
import Realm
import SwiftKit

class ChoosingController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let realm = RLMRealm.defaultRealm()
    private let segmentedControl = UISegmentedControl(items: ["Classes", "Teachers"])
    private let cellIdentifier = "Cell"
    
    var classes: [ClassModel] = []
    var teachers: [TeacherModel] = []
    
    let onClassSelected = Event<ChoosingController, ClassModel>()
    let onTeacherSelected = Event<ChoosingController, TeacherModel>()
    
    override func loadView() {
        super.loadView()
        
        loadData()
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(ChooserTableCell.self, forCellReuseIdentifier: cellIdentifier)
        
        segmentedControl.tintColor = UIColor.whiteColor()
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.valueChanged += { [unowned self] data in
            self.tableView.reloadData()
        }
        
        navigationItem.titleView = segmentedControl
        navigationItem.hidesBackButton = true
    }
    
    private func loadData() {
        for aClass in ClassModel.allObjects() {
            classes.append(aClass as! ClassModel)
        }
        for teacher in TeacherModel.allObjects() {
            teachers.append(teacher as! TeacherModel)
        }
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
        if(segmentedControl.selectedSegmentIndex == 0) {
            onClassSelected.fire(self, input: classes[indexPath.row])
        } else {
            onTeacherSelected.fire(self, input: teachers[indexPath.row])
        }
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(segmentedControl.selectedSegmentIndex == 0) {
            return Int(classes.count)
        } else {
            return Int(teachers.count)
        }
    }
}
