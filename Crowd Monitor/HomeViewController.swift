//
//  HomeViewController.swift
//  Crowd Monitor
//
//  Created by Swamita on 19/03/21.
//

import UIKit
import AVKit
import AVFoundation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var thresholdTextField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var alerts = [["Alert!", "The count has reached the threshold value.", "7:30"], ["Warning", "75% of threshold value reached.","7:25"]]
    
    var selectedThreshold = "5"
    let thresholdList = ["4","5", "10", "15", "20", "35", "40", "55", "60", "75"]
    
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        thresholdTextField.delegate = self
        thresholdTextField.text = "5"
        countLabel.text = "00"
        picker.delegate = self
        picker.dataSource = self
        tableView.register(UINib(nibName: "AlertTableViewCell", bundle: nil), forCellReuseIdentifier: "alertCell")
        thresholdTextField.inputView = picker
        dismissPickerView()
        videoView.isHidden = true
        
    }
    
    @IBAction func playClicked(_ sender: Any) {
        playButton.isHidden = true
        videoView.isHidden = false
        playVideo()
    }
    
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "video", ofType:"mp4") else {
            debugPrint("video.mp4 not found")
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds
        videoView.layer.addSublayer(playerLayer)
        player.play()
        changeCount()
    }
    
    func changeCount() {
        
        var runCount = 0
        var crowdCount = 0
        var prevCount = -1
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            //
            switch runCount {
            
            case -1:
                crowdCount = 0
            case 0:
                crowdCount = 0
            case 1:
                crowdCount = 1
            case 2:
                crowdCount = 1
            case 3:
                crowdCount = 2
            case 4:
                crowdCount = 4
            case 5:
                crowdCount = 4
            case 6:
                crowdCount = 4
            case 7:
                crowdCount = 4
            case 8:
                crowdCount = 3
            case 9:
                crowdCount = 3
            case 10:
                crowdCount = 4
            case 11:
                crowdCount = 4
            case 12:
                crowdCount = 4
                DispatchQueue.main.async {
                    self.playButton.isHidden = false
                    self.videoView.isHidden = true
                }
                
            default:
                crowdCount = 4
            }
            self.countLabel.text = "0\(crowdCount)"
            
            if Int(prevCount) !=  Int(crowdCount){
                //print("\(runCount): \(prevCount) current \(crowdCount)")
                let threshString = self.thresholdTextField.text
                let threshold = Int(threshString ?? "5")
                self.checkCrowd(thresh: threshold ?? 5, count: crowdCount)
            }
            
            
            runCount += 1
            prevCount = crowdCount
            
            if runCount == 12 {
                timer.invalidate()
            }
        }
    }
    
    func checkCrowd(thresh: Int, count: Int) {
        if count >= thresh {
            let title = "Alert!"
            let message = "The count has reached the threshold value."
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let time = dateFormatter.string(from: date)
            let alert = [title, message, time]
            alerts.append(alert)
            
            tableView.reloadData()
            let lastRow: Int = self.tableView.numberOfRows(inSection: 0) - 1
            let indexPath = IndexPath(row: lastRow, section: 0);
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            
    }
        
        else if Double(count) >= 0.75*Double(thresh) {
            let title = "Warning!"
            let message = "75% of threshold value reached."
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let time = dateFormatter.string(from: date)
            let alert = [title, message, time]
            alerts.append(alert)
            
            tableView.reloadData()
            let lastRow: Int = self.tableView.numberOfRows(inSection: 0) - 1
            let indexPath = IndexPath(row: lastRow, section: 0);
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alertCell") as! AlertTableViewCell
        let details = alerts[indexPath.row]
        cell.titleLabel.text = details[0]
        cell.descriptionLabel.text = details[1]
        cell.timeLable.text = details[2]
        cell.titleLabel.textColor = details[0] == "Alert!" ? UIColor.red : UIColor.yellow
        return cell
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return thresholdList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return thresholdList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedThreshold = thresholdList[row]
        thresholdTextField.text = selectedThreshold
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        thresholdTextField.inputAccessoryView = toolBar
    }
    @objc func action() {
        view.endEditing(true)
    }
}
