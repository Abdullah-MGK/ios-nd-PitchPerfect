//
//  ViewController.swift
//  ios-voice-recorder
//
//  Created by Abdullah Khayat on 4/3/20.
//  Copyright © 2020 TeamIos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var RecordBTN: UIButton!
    
    @IBOutlet weak var RecordLBL: UILabel!
    
    var recordIsTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        if !recordIsTapped {
            RecordLBL.text = "Recording ..."
            RecordBTN.setTitle("Stop", for: .normal)
            RecordBTN.backgroundColor = .darkGray
            recordIsTapped = true
        }
        else {
            RecordLBL.text = "Tap to Record"
            RecordBTN.setTitle("Record", for: .normal)
            RecordBTN.backgroundColor = .systemPink
            recordIsTapped = false
        }
    }
}
