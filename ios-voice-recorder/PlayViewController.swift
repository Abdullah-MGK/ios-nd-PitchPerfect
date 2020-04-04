//
//  PlayViewController.swift
//  ios-voice-recorder
//
//  Created by Abdullah Khayat on 4/4/20.
//  Copyright © 2020 TeamIos. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    var recordedAudioURL: URL!
    var audioFile : AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var stopTimer : Timer!
    
    @IBOutlet weak var slowBTN: UIButton!
    @IBOutlet weak var fastBTN: UIButton!
    @IBOutlet weak var lowpitchBTN: UIButton!
    @IBOutlet weak var fastpitchBTN: UIButton!
    @IBOutlet weak var echoBTN: UIButton!
    @IBOutlet weak var reverbBTN: UIButton!
    @IBOutlet weak var stopBTN: UIButton!
    @IBOutlet weak var playBTN: UIButton!
    
    enum ButtonType: Int {
        case slow = 0, fast, lowpitch, fastpitch, echo, reverb, play
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    
    @IBAction func play(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .fastpitch:
            playSound(pitch: 1000)
        case .lowpitch:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        case .play:
            playSound()
        }
        configureUI(.playing)
    }
    
    @IBAction func stop(_ sender: UIButton) {
        stopAudio()
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
