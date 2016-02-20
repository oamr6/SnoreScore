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
    var monitorTimer = NSTimer()
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
        let str =  documents.stringByAppendingPathComponent("snoreRecording.m4a")
        let url = NSURL.fileURLWithPath(str as String)
        
        // make a dictionary to hold the recording settings so we can instantiate our AVAudioRecorder
        let recordSettings: [String : AnyObject] = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue]
        
        // Instantiate an AVAudioRecorder
        do {
            try recorder = AVAudioRecorder(URL: url, settings: recordSettings)
        } catch { }
        
        recorder.prepareToRecord()
        recorder.meteringEnabled = true
        
        // Instantiate a timer to be called with whatever frequency we want to grab metering values
        monitorTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "monitorTimer:", userInfo: nil, repeats: true)
        
    }
    
    //This selector/function is called every time our timer (monitorTimer) fires
    func monitorTimerCallback() {
        recorder.updateMeters()
        print(recorder.averagePowerForChannel(0))
    }
    
    func stopMonitor() {
        if (recorder.recording) {
            recorder.stop();
        }
    }
    
    func startMonitor() {
        if (!recorder.recording) {
            recorder.record()
        }
    }
    
    
}




