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
    var recordFinishedCallback : ((_ isSuccess: Bool, _ itemName: String?) -> Void)!;
    
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
    
    func startRecord(name: String) {
        loadRecord(name: name);
        startSession();
        recorder.prepareToRecord();
        recorder.record();
    }
    
    func stopRecord(){
        recorder.stop();
        stopSession();
    }
    
    func loadRecord (name: String) {
        let settings = [AVSampleRateKey:NSNumber(value: 8000),
                        AVFormatIDKey:NSNumber(value: kAudioFormatLinearPCM),
                        AVLinearPCMBitDepthKey:NSNumber(value: 16),
                        AVNumberOfChannelsKey:NSNumber(value: 1),
                        AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.min.rawValue)
                        ] as [String : Any];
        let path = TODOFileHelper.shared.audioCachePath()
        let name = path! + "/\(name)" + ".caf";
        do{
            try recorder = AVAudioRecorder.init(url: URL.init(fileURLWithPath: name), settings: settings);
            recorder.delegate = self;
        }catch{
            print(error);
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if recordFinishedCallback != nil{
            self.recordFinishedCallback(flag, recorder.url.lastPathComponent);
        }
        if flag{
            print(recorder);
        }else{
            print("录音失败！录音失败！");
        }
    }
}
