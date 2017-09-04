//
//  TODOFileHelper.swift
//  TODOList
//
//  Created by zhuo on 2017/8/4.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import UIKit

class TODOFileHelper: NSObject {
     func saveImage(image: UIImage, name: String) -> Bool {
        let path = imageCachePath() + "\(name)"
        let data = UIImagePNGRepresentation(image);
        do{
            try data?.write(to: URL(fileURLWithPath:path));
        }catch{
            return false;
        }
        return true;
    }
    
     func saveAduio(audioData: Data, name: String) -> Bool {
        let path = imageCachePath() + "\(name)"
        let targetURL : URL! =  URL.init(fileURLWithPath: path);
        do{
            try audioData.write(to: targetURL!);
        }catch{
            return false;
        }
        return true;
    }
    
    
    func fetchImageByName(name: String) -> UIImage? {
        let path = imageCachePath() + "\(name)"
        let tempURL =  URL(fileURLWithPath:path);
        do{
            let data = try Data.init(contentsOf: tempURL, options: .uncached);
            let image = UIImage.init(data: data);
            return image;
        }catch{
            return nil;
        }
    }
    
    func fetchAudioByName(name: String) -> Data? {
        let path = imageCachePath() + "\(name)"
        let targetURL : URL! =  URL.init(fileURLWithPath: path);
        do{
            let data = try Data.init(contentsOf: targetURL, options: .uncached);
            return data;
        }catch{
            return nil;
        }
    }
    
    private func imageCachePath() -> String! {
        let fileManager = FileManager.default;
        let path = NSHomeDirectory()+"/Library/Caches/images";
        if fileManager.fileExists(atPath: path) == false{
            do{
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil);
            }catch{
                print(error);
            }
        }
        return path;
    }
    
    private func audioCachePath() -> String! {
        let fileManager = FileManager.default;
        let path = NSHomeDirectory()+"/Library/Caches/audio";
        if fileManager.fileExists(atPath: path) == false{
            do{
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil);
            }catch{
                print(error);
            }
        }
        return path;
    }

}
