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
            
            // move these to start recording
            RecordLBL.text = "Recording ..."
            RecordBTN.setImage(UIImage(named: "Stop"), for: .normal)
            recordIsTapped = true
        }
        else {
            stopRecording()
            
            // move these to stop recording
            RecordLBL.text = "Tap to Record"
            RecordBTN.setImage(UIImage(named: "Record"), for: .normal)
            recordIsTapped = false
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
        if flag {
            performSegue(withIdentifier: "StopRecord", sender: audioRecorder.url)
        }
        else {
            
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
    
    // THIS doesn't need to be overriden, JUST call it
    // Initiates the segue with the specified identifier from the current view controller's storyboard file
    //  override func performSegue(withIdentifier identifier: String, sender: Any?) {
    // }
    
    // THIS performs the segue if it returns true, needs to OVERRIDDE
    // Determines whether the segue with the specified identifier should be performed
    // Subclasses can override this method and use it to perform segues conditionally based on current conditions. If you do not implement this method, all segues are performed.
    //        override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    //            if recordIsTapped {
    //                return true
    //            }
    //            else {
    //                return false
    //            }
    //        }
}
