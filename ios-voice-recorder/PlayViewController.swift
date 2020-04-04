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
        setupAudio()
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

/*
 // https://classroom.udacity.com/courses/ud1025/lessons/f4db5826-41f1-43b7-9e2b-06a1416bb23b/concepts/5155ae8e-04bd-4baf-92f2-2da926242f42
 // When or Why delegate ...
 You probably noticed that try as you might, you couldn't get the silly song lyrics to display after putting in a name! There’s one final piece missing—there’s no obvious way to get out of the name field once you’ve typed in a name. We could add a button to kick things off, but what would feel best is to just type in our name and press Return, hiding the keyboard and displaying the new lyrics. We can respond to the user pressing Return by making our view controller conform to the UITextFieldDelegate protocol.
 
 // How delegate work ...
 Note: UIKit uses the delegate pattern frequently to allow the same classes to exhibit different behaviors in different contexts. Rather than having to write your own text field class with specific behaviors when a user types a new character or begins or ends editing, adding a delegate to a system-provided text field lets you easily respond to those events.
 
 // Organize view controllers using extensions
 Swift extensions are a handy way to organize the parts of our class that act as delegates or data sources. Create a ViewController extension that adds conformance to UITextFieldDelegate. The delegate method we want to supply is called textFieldShouldReturn and is called whenever a user presses the return key inside a text field.
 */
 
