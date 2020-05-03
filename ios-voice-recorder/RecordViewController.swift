//
//  RecordViewController.swift
//  ios-voice-recorder
//
//  Created by Abdullah Khayat on 4/3/20.
//  Copyright © 2020 TeamIos. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var RecordBTN: UIButton!
    @IBOutlet weak var RecordLBL: UILabel!
    
    /*
     var audioRecorder: AVAudioRecorder!
     audioRecorder.delegate = self
     */
    
    var recordIsTapped = false
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        if !recordIsTapped {
            startRecording()
        }
        else {
            stopRecording()
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
        
        RecordLBL.text = "Recording ..."
        RecordBTN.setImage(UIImage(named: "Stop"), for: .normal)
        recordIsTapped = true
        
    }
    
    func stopRecording() {
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
        // audioRecorderDidFinishRecording() will be called
    }
    
    // called after stopRecording()
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        RecordLBL.text = "Processing ..."
        
        if flag {
            performSegue(withIdentifier: "StopRecord", sender: audioRecorder.url)
        }
            
        else {
            
            RecordLBL.text = "Tap to Record"
            RecordBTN.setImage(UIImage(named: "Record"), for: .normal)
            recordIsTapped = false
            
            let alert = UIAlertController(
                title: "Audio Recorder Error",
                message: "Saving your record was failing",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StopRecord" {
            let playViewController = segue.destination as! PlayViewController
            let recordedAudioURL = sender as! URL
            playViewController.recordedAudioURL = recordedAudioURL
        }
    }
}
