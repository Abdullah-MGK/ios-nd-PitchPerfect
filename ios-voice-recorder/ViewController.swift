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
        print(recordIsTapped)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        if !recordIsTapped {
            RecordLBL.text = "Recording ..."
//            RecordBTN.setTitle("Stop", for: .normal)
//            RecordBTN.backgroundColor = .darkGray
            RecordBTN.setBackgroundImage(UIImage(named: "Stop"), for: .normal)
            recordIsTapped = true
        }
        else {
            RecordLBL.text = "Tap to Record"
//            RecordBTN.setTitle("Record", for: .normal)
//            RecordBTN.backgroundColor = .systemPink
            RecordBTN.setBackgroundImage(UIImage(named: "Record"), for: .normal)
            recordIsTapped = false
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if recordIsTapped {
            return true
        }
        else {
            return false
        }
    }
}
