//
//  DataViewController.swift
//  Crowd Monitor
//
//  Created by Swamita on 20/03/21.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let points = ["1s","2s", "3s", "4s", "5s", "6s", "7s", "8s", "9s", "10s", "11s"]
    let value = [1,1,2,4,4,4,4,3,3,4,4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "dataCell")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}

extension DataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as! DataTableViewCell
        cell.countLabel.text = "\(value[indexPath.row])"
        cell.timeLabel.text = points[indexPath.row]
        return cell
    }
}
