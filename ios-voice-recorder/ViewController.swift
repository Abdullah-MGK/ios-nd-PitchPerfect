//
//  ViewController.swift
//  ios-voice-recorder
//
//  Created by Abdullah Khayat on 4/3/20.
//  Copyright © 2020 TeamIos. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var RecordBTN: UIButton!
    @IBOutlet weak var RecordLBL: UILabel!
    
    var recordIsTapped = false
    var audioRecorder: AVAudioRecorder!
    
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
            //startRecording()
        }
        else {
            RecordLBL.text = "Tap to Record"
            //            RecordBTN.setTitle("Record", for: .normal)
            //            RecordBTN.backgroundColor = .systemPink
            RecordBTN.setBackgroundImage(UIImage(named: "Record"), for: .normal)
            recordIsTapped = false
            //stopRecording()
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
    
    func startRecording() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func stopRecording() {
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
    }
    
}
