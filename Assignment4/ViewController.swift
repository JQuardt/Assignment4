//
//  ViewController.swift
//  Assignment4
//
//  Created by Jenna Marquardt on 2/1/24.
//

import UIKit

class ViewController: UIViewController {
    //Wed, 28 Dec 2022 14:59:00
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Update Date Label
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeLabel), userInfo: nil, repeats: true)
    }
    
    @objc func changeLabel() {
        var dateFormatter = DateFormatter()
        //"E, d MMM yyyy HH:mm:ss"
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        var date = Date()
        dateLabel.text = dateFormatter.string(from: date)
    }
}

