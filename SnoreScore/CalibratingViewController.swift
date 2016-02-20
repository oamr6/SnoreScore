//
//  CalibratingViewController.swift
//  SnoreScore
//
//  Created by MU IT Program on 2/19/16.
//  Copyright © 2016 Corey Matzat. All rights reserved.
//

import UIKit
import AVFoundation

class CalibratingViewController: UIViewController {
    
    //var monitor: AudioMonitor!
    var recorder: AVAudioRecorder!
    var timer = NSTimer()

    @IBOutlet weak var CalibrationStatus: UIActivityIndicatorView!
    @IBOutlet weak var CalibrationLabel: UILabel!
    @IBOutlet weak var CalButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        CalibrationStatus.stopAnimating()
        //CalibrationStatus.hidden = true
        //monitor = AudioMonitor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func calibrating(sender: AnyObject) {
        CalibrationLabel.text = "Prepare for Microphone Calibration"
        setupAudioRecorder()
        //monitor = AudioMonitor()
        CalibrationStatus.startAnimating()
        CalButton.enabled = false
        //CalibrationLabel.text = NSUserDefaults.standardUserDefaults().integerForKey("numberTimes").description
    }
    
    func setupAudioRecorder() {
        // Make an AudioSession, set it to PlayAndRecord and make it active
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setActive(true)
        } catch {}
        
        // Set up the URL for the audio file
        let documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
        let str =  documents.stringByAppendingPathComponent("recording.m4a")
        let url = NSURL.fileURLWithPath(str as String)
        
        // make a dictionary to hold the recording settings so we can instantiate our AVAudioRecorder
        let recordSettings: [String : AnyObject] = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue]
        
        //Instantiate an AVAudioRecorder
        do {
            try recorder = AVAudioRecorder(URL: url, settings: recordSettings)
        } catch {
        }
        recorder.prepareToRecord()
        recorder.meteringEnabled = true
        
        //start recording
        recorder.record()
        
        //instantiate a timer to be called with whatever frequency we want to grab metering values
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("levelTimerCallback"), userInfo: nil, repeats: true)
        
        
    }
    
    
    func levelTimerCallback() {
        //we have to update meters before we can get the metering values
        recorder.updateMeters()
        
        print(recorder.averagePowerForChannel(0))
        print(recorder.peakPowerForChannel(0))
        print("")
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
