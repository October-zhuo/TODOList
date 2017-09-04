//
//  TODODetailAudioCell.swift
//  TODOList
//
//  Created by zhuo on 2017/8/2.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import UIKit

class TODODetailAudioCell: UITableViewCell, TODODetailListCellProtocol{

    var recordBtn : UIButton? = nil;
    var playBtn : UIButton? = nil;
    var myTask : TODOTask!;
    
    var recorder = TODORecorder();
    func loadTask(task: TODOTask) {
        myTask = task;
        if task.audioName.characters.count > 0{
            playBtn = UIButton.init(frame: .zero);
            playBtn?.setImage(UIImage.init(named: "audio_play"), for: .normal);
            self.contentView.addSubview(playBtn!);
            playBtn?.snp.makeConstraints({ (make) in
                make.center.equalTo(self.contentView);
                make.height.equalTo(self.contentView);
                make.width.equalTo(150);
            });
            playBtn?.addTarget(self, action: #selector(didClickPlayBtn), for: .touchUpInside);
        }else{
            playBtn = UIButton.init(frame: .zero);
            playBtn?.setImage(UIImage.init(named: "audio_play"), for: .normal);
            self.contentView.addSubview(playBtn!);
            playBtn?.snp.makeConstraints({ (make) in
                make.center.equalTo(self.contentView);
                make.height.equalTo(self.contentView);
                make.width.equalTo(150);
            });
            playBtn?.addTarget(self, action: #selector(didClickPlayBtn), for: .touchUpInside);
            
            recordBtn = UIButton();
            recordBtn?.setImage(UIImage.init(named: "audio_record"), for: .normal);
            self.contentView.addSubview(recordBtn!);
            recordBtn?.snp.makeConstraints({ (make) in
                make.center.equalTo(self.contentView);
                make.height.equalTo(self.contentView);
                make.width.equalTo(150);
            })
            recordBtn?.addTarget(self, action: #selector(beginToRecord), for: .touchDown);
            recordBtn?.addTarget(self, action: #selector(stopToRecord), for: .touchUpInside);
            
            playBtn?.isHidden = true;
            recordBtn?.isHidden = false;
        }
    }
    
    func removeAllObservers() {
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none;
        recorder.recordFinishedCallback = {[weak self] (isSuccess:Bool, itemName: String?) in
            if isSuccess {
                self?.myTask.audioName = itemName!;
                self?.recordBtn?.isHidden = true;
                self?.playBtn?.isHidden = false;
            }else{
                print("record audio error");
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func beginToRecord(){
        let date = Date().timeIntervalSince1970;
        recorder.startRecord(name: "\(date)");
    }
    
    @objc func stopToRecord(){
        recorder.stopRecord();
    }
    
    @objc func didClickPlayBtn(){
        let path = TODOFileHelper.shared.audioCachePath()
        let audioString = path! + "/\(self.myTask.audioName)";
        let audioURL = URL.init(fileURLWithPath: audioString);
        TODOAudioPlayer.shared.switchPlayerStatus(URL: audioURL);
    }
}
