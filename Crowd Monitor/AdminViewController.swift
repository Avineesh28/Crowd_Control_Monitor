//
//  AdminViewController.swift
//  Crowd Monitor
//
//  Created by Swamita on 20/03/21.
//

import UIKit

class AdminViewController: UIViewController {

    @IBOutlet weak var staffTableView: UITableView!
    
    var staff = ["John Kelly"]
    var codes = ["ags817","hjd173","osy652"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        staffTableView.dataSource = self
        staffTableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "dataCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func addStaffPressed(_ sender: Any) {
        addStaff()
    }
    
    func addStaff() {
        let dialogMessage = UIAlertController(title: "Add Staff", message: "Enter the name of new staff member", preferredStyle: .alert)
        
        dialogMessage.addTextField(configurationHandler: { textField in
            textField.placeholder = "Type Name"
        })
        
        let ok = UIAlertAction(title: "Done", style: .default, handler: { (action) -> Void in
            self.staff.append(dialogMessage.textFields?.first?.text ?? "")
            self.staffTableView.reloadData()
        })
        
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)

    }
    
}

extension AdminViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        staff.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as! DataTableViewCell
        cell.countLabel.text = codes[indexPath.row]
        cell.timeLabel.text = staff[indexPath.row]
        return cell
    }
    
    
}
