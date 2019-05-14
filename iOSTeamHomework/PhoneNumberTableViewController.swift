//
//  PhoneNumberTableViewController.swift
//  iOSTeamHomework
//
//  Created by willsbor Kang on 2017/9/16.
//  Copyright © 2017年 gogolook. All rights reserved.
//

import UIKit

class PhoneNumberTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(dataChanged), name: PhoneNumberManager.dataChangedNotification, object: nil)
    }


    @IBAction func addPhoneNumber() {
        let d = NumberData(code: Int(arc4random() % 9 + 1), number: Int(arc4random() % 90000000 + 10000000))
        PhoneNumberManager.sharedInstance.add(d)
    }
    
    @IBAction func savePhoneNumbers() {
        PhoneNumberManager.sharedInstance.save()
    }
    
    @objc func dataChanged() {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return PhoneNumberManager.sharedInstance.getCodes().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let code = PhoneNumberManager.sharedInstance.getCodes()[section]
        return PhoneNumberManager.sharedInstance.getNumbers(for: code).count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let code = PhoneNumberManager.sharedInstance.getCodes()[section]
        return "\(code)"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)

        let code = PhoneNumberManager.sharedInstance.getCodes()[indexPath.section]
        let data = PhoneNumberManager.sharedInstance.getNumbers(for: code)[indexPath.row]
        
        cell.textLabel?.text = "\(data.number)"
        cell.detailTextLabel?.text = "\(data.code) \(data.number)"

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let code = PhoneNumberManager.sharedInstance.getCodes()[indexPath.section]
            let data = PhoneNumberManager.sharedInstance.getNumbers(for: code)[indexPath.row]
            PhoneNumberManager.sharedInstance.remove(data)
        }
    }
}
