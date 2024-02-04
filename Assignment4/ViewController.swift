//
//  Assignment4
//
//  Created by Jenna Marquardt on 2/1/24.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    //Wed, 28 Dec 2022 14:59:00
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timerButton: UIButton!
    var timer = Timer()
    var timeLeft : Double = 0
    var musicPlaying : Bool = false
    var player: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Update Date and Time Label
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeLabel), userInfo: nil, repeats: true)
        timeRemainingLabel.text = ""
        //music
        let url = Bundle.main.url(forResource: "song", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
    }
    
    // Change Date and Time Label
    @objc func changeLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        let date = Date()
        dateLabel.text = dateFormatter.string(from: date)
        let components = Calendar.current.dateComponents([.hour], from: date)
        let hour = components.hour ?? 0
        if hour < 12 {
            backgroundImage.image = UIImage(named: "am")
        } else {
            backgroundImage.image = UIImage(named: "pm")
        }
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        //If timer going, stop timer...
        timer.invalidate()
        timeRemainingLabel.text = ""
        if ((player?.isPlaying) == false || (player?.isPlaying) == nil) {
            //start timer
            timeLeft = datePicker.countDownDuration
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeTime), userInfo: nil, repeats: true)
            
        } else {
            player?.stop()
            timerButton.titleLabel?.text = "Start Timer"
        }
    }
    
    @objc func changeTime() {
        //Timer has counted down to zero...
        if timeLeft == 0 {
            //if 0 and song not playing
            player?.play()
            //start song
            timeRemainingLabel.text = ""
            timerButton.titleLabel?.text = "Stop Music"
            timeLeft = -1
        //if song is playing
        } else if (timeLeft == -1 && player?.isPlaying == true) {
            //do nothing
        //if song has stopped..
        } else if (timeLeft == -1 && player?.isPlaying == false) {
            timer.invalidate()
            timerButton.titleLabel?.text = "Start Timer"
            timeLeft = 0
        } else { // Timer button hit (start or reset)
            timerButton.titleLabel?.text = "Reset Timer"
            let hour = floor(timeLeft / 3600)
            let minute = floor((timeLeft - (hour * 3600)) / 60)
            let second = timeLeft - (hour * 3600) - (minute * 60)
            timeRemainingLabel.text = "Time Remaining: \(Int(hour)):\(Int(minute)):\(Int(second))"
            timeLeft -= 1
        }
    }
    
}

