//
//  TODOAudioPlayer.swift
//  TODOList
//
//  Created by zhuo on 2017/8/7.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import AVFoundation

class TODOAudioPlayer : NSObject, AVAudioPlayerDelegate{
    
    var player : AVAudioPlayer? = nil;
    
    static let shared = TODOAudioPlayer();
    
    func playWithURL(URL : URL) {
        do{
            try player = AVAudioPlayer.init(contentsOf: URL);
            let playerSession = AVAudioSession.sharedInstance();
            do{
                try playerSession.setCategory(AVAudioSessionCategoryPlayback)
                try playerSession.setActive(true);
            }catch{
                print(error);
            }
            player?.delegate = self;
            player?.volume = 1;
            player?.prepareToPlay();
            player?.play();
        }catch{
            print(error);
        }
    }
    
    func stopPlay() {
            player?.stop();
            player = nil;
    }
    
    func switchPlayerStatus(URL: URL) {
        if let playing = player?.isPlaying {
            if (playing) {
                player?.stop();
            }else{
                playWithURL(URL: URL);
            }
        }else{
            playWithURL(URL: URL);
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopPlay();
    }
    
    func audioPlayerBeginInterruption(_ player: AVAudioPlayer) {
        stopPlay();
    }
}
