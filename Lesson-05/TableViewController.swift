//
//  TableViewController.swift
//  Lesson-05
//
//  Created by pham.xuan.tien on 12/17/18.
//  Copyright © 2018 pham.xuan.tien. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var countryData:[(code: String, name: String)] = []
    var numberOfRowDisplay = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromJson()
        addRefreshControl()
    }

    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowDisplay
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath) as! CustomTableViewCell
        cell.countryCode.text = countryData[indexPath.row].code
        cell.countryName.text = countryData[indexPath.row].name
        cell.countryFlag.image = UIImage(named: countryData[indexPath.row].code.lowercased())
        return cell
    }

    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, _) in
            self.countryData.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        deleteAction.backgroundColor = .red
        return [deleteAction]
    }

    // MARK: - Load Data
    func loadDataFromJson() {
        do {
            if let file = Bundle.main.url(forResource: "countries", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let resultJson = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
                let sorted = resultJson!.sorted {$0.key < $1.key}
                for (key, value) in sorted {
                    countryData.append((code: key, name: value))
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }

    // MARK: - Add Refresh Control
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        self.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    @IBAction func startEditTableTapped(_ sender: Any) {
        self.isEditing = !isEditing
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = countryData[fromIndexPath.row]
        countryData.remove(at: fromIndexPath.row)
        countryData.insert(itemToMove, at: to.row)
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = numberOfRowDisplay - 1
        if indexPath.row == lastElement {
            if(numberOfRowDisplay + 10 > countryData.count) {
                numberOfRowDisplay = countryData.count
            } else {
                numberOfRowDisplay += 10
            }
            self.tableView.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
