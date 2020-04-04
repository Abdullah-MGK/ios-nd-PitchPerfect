//
//  PlayViewController.swift
//  ios-voice-recorder
//
//  Created by Abdullah Khayat on 4/4/20.
//  Copyright © 2020 TeamIos. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    var recordedAudioURL: URL!
    
    
    @IBOutlet weak var slowBTN: UIButton!
    
    @IBOutlet weak var fastBTN: UIButton!
    
    @IBOutlet weak var lowpitchBTN: UIButton!
    
    @IBOutlet weak var fastpitchBTN: UIButton!
    
    @IBOutlet weak var echoBTN: UIButton!
    
    @IBOutlet weak var reverbBTN: UIButton!
    
    @IBOutlet weak var stopBTN: UIButton!
    
    @IBOutlet weak var playBTN: UIButton!
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func play(_ sender: UIButton) {
        
    }
    
    @IBAction func stop(_ sender: UIButton) {
        
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
