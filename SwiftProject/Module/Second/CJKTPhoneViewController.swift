//
//  CJKTPhoneViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/29.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class CJKTPhoneViewController: CJKTBaseViewController {
    var imgUrl: String!
    var titleStr: String!
    lazy var iconImgV: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleAspectFit
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.barStyle(.theme)
        view.addSubview(iconImgV)
        iconImgV.snp.makeConstraints{
        $0.edges.equalTo(view.snp.edges)
        }
        iconImgV.isUserInteractionEnabled = true
        guard let url = imgUrl else {return}
        iconImgV.kf.setImage(with: URL(string: url),
                                        placeholder: UIImage.init(named: "normal_placeholder_h"), options:[.transition(.fade(0.2))])
        
        
//
        guard let str = titleStr else {return}
        navigationController?.navigationItem.title = str
        kLog("titleStr = \(titleStr.debugDescription)")
          
        // 手势
               
//               单击浏览
               let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapGesture))
               singleTap.numberOfTapsRequired = 1
               view.addGestureRecognizer(singleTap)
//               双击放大
               let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
               doubleTap.numberOfTapsRequired = 2
               view.addGestureRecognizer(doubleTap)
               
               singleTap.require(toFail: doubleTap)
               
               let pinch = UIPinchGestureRecognizer(target: self, action: #selector(interactionGesture(recognizer:)))
               view.addGestureRecognizer(pinch)
//               捏合放大 旋转捏合取消浏览
               let rotate = UIRotationGestureRecognizer(target: self, action: #selector(interactionGesture(recognizer:)))
               view.addGestureRecognizer(rotate)
        
//               长按保存到相册
               let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(recognizer:)))
               view.addGestureRecognizer(longPress)
               
               pinch.delegate = self
               rotate.delegate = self
    }
    
    
    
   
    
    //MARK: - 监听方法
       @objc private func singleTapGesture() {
//           animator.fromImageView = currentViewer?.imageView
//           dismiss(animated: true, completion: nil)
       }
       
       @objc private func doubleTapGesture(recognizer: UIGestureRecognizer) {
           

       }
       
       @objc private func interactionGesture(recognizer: UIGestureRecognizer) {
           

       }
       
       @objc private func longPressGesture(recognizer: UILongPressGestureRecognizer) {
           guard recognizer.state != .began else {
               return
           }
           
           guard iconImgV.image != nil else {
               return
           }

           let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
           actionSheet.addAction(UIAlertAction(title: "保存至相册", style: .destructive, handler: { (action) in
            
            UIImageWriteToSavedPhotosAlbum(self.iconImgV.image!, self, #selector(self.image(image:DidFinishSavingWithError:contextInfo:)), nil)
           }))

           actionSheet.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))

           present(actionSheet, animated: true, completion: nil)
       }
       
       @objc func image(image: UIImage, DidFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        
          self.showAlert(msg: (error == nil) ? "保存成功" : "保存失败")
        
           UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: {
//               self.messageLabel.transform = CGAffineTransform.identity
           }) { (completion) in
               UIView.animate(withDuration: 0.5, animations: {
//                   self.messageLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
               })
           }
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension CJKTPhoneViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
