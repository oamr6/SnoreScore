//
//  AudioMonitor.swift
//  SnoreScore
//
//  Created by Corey Matzat on 2/20/16.
//  Copyright © 2016 Corey Matzat. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AudioMonitor {
    
    var recorder: AVAudioRecorder!
    var levelTimer = NSTimer()
    var lowPassResults: Double = 0.0
    
    init() {
        // Make an AudioSession, set it to PlayAndRecord and make it active
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setActive(true)
        } catch {}
        
        // Setup the URL for the audio file
        let documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
        let str =  documents.stringByAppendingPathComponent("recordTest.caf")
        let url = NSURL.fileURLWithPath(str as String)
        
        // make a dictionary to hold the recording settings so we can instantiate our AVAudioRecorder
        let recordSettings: [String : AnyObject] = [AVFormatIDKey:Int(kAudioFormatAppleIMA4),
            AVSampleRateKey:44100.0,
            AVNumberOfChannelsKey:2,AVEncoderBitRateKey:12800,
            AVLinearPCMBitDepthKey:16,
            AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue]
        
        // Instantiate an AVAudioRecorder
        do {
            try recorder = AVAudioRecorder(URL: url, settings: recordSettings)
        } catch {
        }
        recorder.prepareToRecord()
        recorder.meteringEnabled = true
        
        // Start recording
        recorder.record()
        
        // Instantiate a timer to be called with whatever frequency we want to grab metering values
        self.levelTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("levelTimerCallback"), userInfo: nil, repeats: true)
        
    }
    
    //This selector/function is called every time our timer (levelTime) fires
    func levelTimerCallback() {
        recorder.updateMeters()
        print(recorder.averagePowerForChannel(0))
    }
    
    
}




