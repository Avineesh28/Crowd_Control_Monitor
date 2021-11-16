//
//  VideoViewController.swift
//  Crowd Monitor
//
//  Created by Swamita on 04/06/21.
//


import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    }
}
