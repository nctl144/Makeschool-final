//
//  WaterViewController.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/27/17.
//  Copyright © 2017 lam. All rights reserved.
//

import UIKit
import Material

class WaterViewController: UIViewController {
    @IBOutlet weak var waterConfirmButton: FlatButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var seconds = 100
    var timer = Timer()
    var isTimeRunning = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareTabBarItem()
    }
    
    private func prepareTabBarItem() {
        tabBarItem.title = "Water"
        tabBarItem.image = Icon.starBorder?.tint(with: Color.blueGrey.base)
        tabBarItem.selectedImage = Icon.starBorder?.tint(with: Color.blue.base)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timeLabel.text = "\(timeString(time: TimeInterval(seconds)))"
        runTimer()
    }
    
    @IBAction func waterButtonTapped(_ sender: UIButton) {
        print("water button tapped")
    }
}

extension WaterViewController {
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        print("this is running")
    }
    
    func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
        } else {
            seconds -= 1
            timeLabel.text = "\(timeString(time: TimeInterval(seconds)))"
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}
