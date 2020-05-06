//
//  CJKTPhotoBrowserCell.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/30.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class CJKTPhotoBrowserCell: UICollectionViewCell {
    //滚动视图
    lazy var scrollView:UIScrollView = {
        let scr = UIScrollView(frame: self.contentView.bounds)
       scr.delegate = self
       //scrollView缩放范围 1~3
       scr.maximumZoomScale = 3.0
       scr.minimumZoomScale = 1.0
       return scr
    }()
    
    //用于显示图片的imageView
   
    lazy var imageView: UIImageView = {
        let img = UIImageView.init()
        img.frame = scrollView.bounds
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            //隐藏导航栏
            if let nav = self.responderViewController()?.navigationController{
                nav.setNavigationBarHidden(true, animated: true)
            }
           self.contentView.addSubview(scrollView)
           scrollView.addSubview(imageView)
            
//            //单击
//            let tapSingle = UITapGestureRecognizer(target:self,
//                                                 action:#selector(tapSingleDid))
//            self.imageView.addGestureRecognizer(tapSingle)

            //双击
//            let tapDouble = UITapGestureRecognizer(target:self,
//                                                 action:#selector(tapDoubleDid(_:)))
//            tapDouble.numberOfTapsRequired = 2
//
//            //声明点击事件需要双击事件检测失败后才会执行
//            tapSingle.require(toFail: tapDouble)
//            self.imageView.addGestureRecognizer(tapDouble)
    
        
        
            // 长按保存到相册
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(recognizer:)))
            self.imageView.addGestureRecognizer(longPress)
        
        //滑动手势

            let swipe = UISwipeGestureRecognizer(target:self, action:#selector(swipeGesture(recognizer:)))
        swipe.direction = .down
            self.imageView.addGestureRecognizer(swipe)
//        //捏合手势（两个手指进行放大缩小）
//        let pinch = UIPinchGestureRecognizer(target:self,action:#selector(pinchDid(_:)))
//        self.imageView.addGestureRecognizer(pinch)
//  // 旋转手势（两个手指进行旋转）
//        let rotation = UIRotationGestureRecognizer(target:self,
//                                                   action:#selector(rotationDid(_:)))
//        self.imageView.addGestureRecognizer(rotation)
        
        }
        
        //重置单元格内元素尺寸
      public  func resetSize(){
            //scrollView重置，不缩放
            scrollView.frame = self.contentView.bounds
            scrollView.zoomScale = 1.0
            //imageView重置
            if let image = self.imageView.image {
                //设置imageView的尺寸确保一屏能显示的下
                imageView.frame.size = scaleSize(size: image.size)
                //imageView居中
                imageView.center = scrollView.center
            }
        }
        
        //视图布局改变时（横竖屏切换时cell尺寸也会变化）
        override func layoutSubviews() {
            super.layoutSubviews()
            //重置单元格内元素尺寸
            resetSize()
        }
        
        //获取imageView的缩放尺寸（确保首次显示是可以完整显示整张图片）
      fileprivate  func scaleSize(size:CGSize) -> CGSize {
            let width = size.width
            let height = size.height
            let widthRatio = width/UIScreen.main.bounds.width
            let heightRatio = height/UIScreen.main.bounds.height
            let ratio = max(heightRatio, widthRatio)
            return CGSize(width: width/ratio, height: height/ratio)
        }
        
        //图片单击事件响应
        @objc func tapSingleDid(_ ges:UITapGestureRecognizer){
            //显示或隐藏导航栏
            if let nav = self.responderViewController()?.navigationController{
                nav.setNavigationBarHidden(!nav.isNavigationBarHidden, animated: true)
            }
        }
        
        //图片双击事件响应
        @objc func tapDoubleDid(_ ges:UITapGestureRecognizer){
            //隐藏导航栏
            if let nav = self.responderViewController()?.navigationController{
                nav.setNavigationBarHidden(true, animated: true)
            }
            //缩放视图（带有动画效果）
            UIView.animate(withDuration: 0.5, animations: {
                //如果当前不缩放，则放大到3倍。否则就还原
                if self.scrollView.zoomScale == 1.0 {
                    self.scrollView.zoomScale = 3.0
                }else{
                    self.scrollView.zoomScale = 1.0
                }
            })
        }
        //图片长按事件响应
      @objc private func longPressGesture(recognizer: UILongPressGestureRecognizer) {
               guard recognizer.state != .began else {
                   return
               }
               
               guard imageView.image != nil else {
                   return
               }

               let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
               actionSheet.addAction(UIAlertAction(title: "保存至相册", style: .destructive, handler: { (action) in
                
                UIImageWriteToSavedPhotosAlbum(self.imageView.image!, self, #selector(self.image(image:DidFinishSavingWithError:contextInfo:)), nil)
               }))

               actionSheet.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))

              
               self.responderViewController()?.present(actionSheet, animated: true, completion: nil)
        
           }
           
           @objc func image(image: UIImage, DidFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
            
              self.responderViewController()?.showAlert(msg: (error == nil) ? "保存成功" : "保存失败")
            
               UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: {
    //               self.messageLabel.transform = CGAffineTransform.identity
               }) { (completion) in
                   UIView.animate(withDuration: 0.5, animations: {
    //                   self.messageLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
                   })
               }
           }
    
////图片滑动事件响应
          @objc  func swipeGesture(recognizer: UISwipeGestureRecognizer){
            CJKTLog("滑动")
            self.responderViewController()?.navigationController?.popViewController(animated: true)
        
         }
        
    //图片捏合手势事件响应
        @objc func pinchDid(_ recognizer:UIPinchGestureRecognizer) {
               //在监听方法中可以实时获得捏合的比例
               print(recognizer.scale)
               //获取两个触摸点的坐标
               print(recognizer.location(ofTouch: 0, in: self.imageView))
               print(recognizer.location(ofTouch: 1, in: self.imageView))
           }
//    旋转手势事件响应
    @objc func rotationDid(_ recognizer:UIRotationGestureRecognizer){
           //旋转的弧度转换为角度
           print(recognizer.rotation*(180/CGFloat.pi))
       }
    
        //查找所在的当前的ViewController
        func responderViewController() -> UIViewController? {
            for view in sequence(first: self.superview, next: { $0?.superview }) {
                if let responder = view?.next {
                    if responder.isKind(of: UIViewController.self){
                        return responder as? UIViewController
                    }
                }
            }
            return nil
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder:aDecoder)
        }
    }



    //ImagePreviewCell的UIScrollViewDelegate代理实现
extension CJKTPhotoBrowserCell:UIScrollViewDelegate{

        //缩放视图
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return self.imageView
        }
        
        //缩放响应，设置imageView的中心位置
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            var centerX = scrollView.center.x
            var centerY = scrollView.center.y
            centerX = scrollView.contentSize.width > scrollView.frame.size.width ?
                scrollView.contentSize.width/2:centerX
            centerY = scrollView.contentSize.height > scrollView.frame.size.height ?
                scrollView.contentSize.height/2:centerY
            print(centerX,centerY)
            imageView.center = CGPoint(x: centerX, y: centerY)
        }
    }


