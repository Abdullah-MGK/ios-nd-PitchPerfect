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
    
    @IBOutlet weak var recordBTN: UIButton!
    @IBOutlet weak var recordLBL: UILabel!
    
    enum RecordingState { case notRecording, recording, recordingEnded }
    
    var recordIsTapped = false
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notRecording)
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
        
        configureUI(.recording)
    }
    
    func stopRecording() {
        let session = AVAudioSession.sharedInstance()
        configureUI(.recordingEnded)
        audioRecorder.stop()
        // audioRecorderDidFinishRecording() will be called
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
        
        configureUI(.notRecording)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StopRecord" {
            let playViewController = segue.destination as! PlayViewController
            let recordedAudioURL = sender as! URL
            playViewController.recordedAudioURL = recordedAudioURL
        }
    }
    
    func configureUI(_ recordState: RecordingState) {
        
        switch(recordState) {
        case .notRecording:
            recordLBL.text = "Tap to Record"
            recordBTN.setImage(UIImage(named: "Record"), for: .normal)
            recordIsTapped = false
            recordBTN.isEnabled = true
            
        case .recording:
            recordLBL.text = "Recording ..."
            recordBTN.setImage(UIImage(named: "Stop"), for: .normal)
            recordIsTapped = true
            recordBTN.isEnabled = true  // delete
            
        case .recordingEnded:
            recordLBL.text = "Processing ..."
            // already: recordBTN.setImage(UIImage(named: "Stop"), for: .normal)
            // already: recordIsTapped = true
            recordBTN.isEnabled = false
        }
    }
}
