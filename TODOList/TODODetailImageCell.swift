//
//  TODODetailImageCell.swift
//  TODOList
//
//  Created by zhuo on 2017/8/2.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import UIKit

class TODODetailImageCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TODODetailListCellProtocol {
    var addPictureBtn : UIButton!;
    var imageTask : TODOTask!
    let kButtonWidthAndHeight = 100;
    let kButtonMargin = 10;
    let kImageObsevePath = "imageList"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none;
         setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == kImageObsevePath {
            configAddButton();
        }
    }
    
    func removeAllObservers() {
        imageTask.removeObserver(self, forKeyPath: kImageObsevePath);
    }
    
    func loadTask(task: TODOTask) {
        imageTask = task;
        imageTask.addObserver(self, forKeyPath:kImageObsevePath , options: .new, context: nil);
        resetAllButtons();
    }
    
    func resetAllButtons() {
        for button in self.contentView.subviews {
            if button.isKind(of: TODOAddImageTaskButton.self) {
                button.removeFromSuperview();
            }
        }
        
        for (index, todoImage) in imageTask.imageList.enumerated() {
            if let image = TODOFileHelper().fetchImageByName(name: todoImage.imageName){
                addBuuton(image: image, index: index);
            }
        }
        configAddButton();
    }
    
    private func setupUI(){
        addPictureBtn = UIButton();
        addPictureBtn.setBackgroundImage(UIImage.init(named: "add_image"), for: .normal);
        addPictureBtn.backgroundColor = UIColor.colorWithHexString(hex: "0xcccccc");
        addPictureBtn.addTarget(self, action: #selector(didClickAddButton), for: .touchUpInside);
        self.contentView.addSubview(addPictureBtn);
        addPictureBtn.frame =  CGRect(x:kButtonMargin,y:kButtonMargin,width:kButtonWidthAndHeight,height:kButtonWidthAndHeight);
    }
    
    func addBuuton(image: UIImage, index:Int) {
        let (x,y) : (CGFloat, CGFloat) = caculateViewOrigin(index: index);
        let button = TODOAddImageTaskButton.init(frame:  CGRectFromString("{{\(x),\(y)},{\(kButtonWidthAndHeight),\(kButtonWidthAndHeight)}}"));
        button.tag = index;
        button.clickClearButtonCallBack = {[weak self] (button: TODOAddImageTaskButton) in
            self?.imageTask.imageList.remove(objectAtIndex: button.tag);
            self?.resetAllButtons();
        }
        button.setImage(image, for: .normal);
        self.contentView.addSubview(button);
    }
    
    func configAddButton(){
        self.addPictureBtn.isHidden = imageTask.imageList.count >= 3;
        let count = imageTask.imageList.count;
        let (x,y) : (CGFloat, CGFloat) = caculateViewOrigin(index: count);
        self.addPictureBtn.frame =  CGRectFromString("{{\(x),\(y)},{\(kButtonWidthAndHeight),\(kButtonWidthAndHeight)}}");
    }
    
    func caculateViewOrigin(index: Int) -> (x: CGFloat, y: CGFloat) {
        let col =  index % 3;
        let row = index / 3;
        let x = col*kButtonWidthAndHeight + (col + 1)*kButtonMargin;
        let y = row*kButtonWidthAndHeight + (row + 1)*kButtonMargin;
        return (CGFloat(x),CGFloat(y));
    }
    
    @objc private func didClickAddButton(){
        if UIImagePickerController.isCameraDeviceAvailable(.rear){
            let picker = UIImagePickerController();
            picker.delegate = self;
            picker.sourceType = .camera;
            UIApplication.shared.keyWindow?.rootViewController?.show(picker, sender: nil);
        }else{
            let alert = UIAlertController.init(title: "权限确认", message: "请允许TODOList使用你的手机相机", preferredStyle: .alert);
            let sureAction = UIAlertAction.init(title: "好的", style: .default, handler: { (action) in
                
            });
            alert.addAction(sureAction);
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil);
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage;
        let date = Date().timeIntervalSince1970;
        if TODOFileHelper().saveImage(image: image,name: "\(date)"){
            let todoImage = TODOImage();
            todoImage.imageWidth = image.leftCapWidth;
            todoImage.imageHeight = image.topCapHeight;
            todoImage.imageName =  "\(date)";
            imageTask.imageList.append(todoImage);
            self.addBuuton(image: image, index: imageTask.imageList.count - 1);
        }
        picker.dismiss(animated: true, completion: nil);
    }
}
