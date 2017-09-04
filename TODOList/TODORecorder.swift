//
//  TODORecorder.swift
//  TODOList
//
//  Created by zhuo on 2017/8/5.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import AVFoundation

class TODORecorder : NSObject, AVAudioRecorderDelegate{
    var recorder : AVAudioRecorder!;
    let session = AVAudioSession.sharedInstance();
    
    func startSession() {
        do{
            try session.setCategory(AVAudioSessionCategoryRecord);
        }catch{
            print(error);
        }
        
        do{
            try session.setActive(true);
        }catch{
            print(error);
        }
    }
    
    func stopSession() {
        do{
            try session.setActive(false);
        }catch{
            print(error);
        }
    }
    
    func startRecord() {
        loadRecord();
        startSession();
        recorder.prepareToRecord();
        recorder.record();
    }
    
    func stopRecord() {
        recorder.stop();
        stopSession();
    }
    
    func loadRecord () {
        let settings = [AVSampleRateKey:8000, AVFormatIDKey:kAudioFormatLinearPCM, AVLinearPCMBitDepthKey:16, AVNumberOfChannelsKey:1, AVLinearPCMIsBigEndianKey: false, AVLinearPCMIsFloatKey:false] as [String : Any];
        let fileManager = FileManager.default;
        let path = NSHomeDirectory()+"/Library/Caches/audio";
        if fileManager.fileExists(atPath: path) == false{
            do{
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil);
            }catch{
                print(error);
            }
        }
        let name = path + "/test.wav";
        do{
            try recorder = AVAudioRecorder.init(url: URL.init(fileURLWithPath: name), settings: settings);
            recorder.delegate = self;
        }catch{
            print(error);
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            print(recorder);
        }else{
            print("录音失败！录音失败！");
        }
    }
}
