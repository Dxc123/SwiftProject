//
//  CJKTPhotoBrowseViewController.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/30.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class CJKTPhotoBrowseViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal////横向滚动
        let cw = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        cw.backgroundColor = UIColor.black//黑色背景
        cw.delegate = self
        cw.dataSource = self
        cw.alwaysBounceHorizontal = true
        cw.isPagingEnabled = true
        cw.register(CJKTPhotoBrowserCell.self, forCellWithReuseIdentifier: "CJKTPhotoBrowserCell")
        //不自动调整内边距，确保全屏
           if #available(iOS 11.0, *) {
               cw.contentInsetAdjustmentBehavior = .never
           } else {
               self.automaticallyAdjustsScrollViewInsets = false
           }
        return cw
        
    }()
    //页控制器（小圆点）
    var pageControl : UIPageControl!
    //存储图片数组
    var images: [String] 
    
    //默认显示的图片索引
    var index: Int
    
    //初始化
    init(images:[String], index:Int = 0){
        self.images = images
        self.index = index
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(self.collectionView)
        
        //将视图滚动到默认图片上
        let indexPath = IndexPath.init(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
        //设置页控制器
        pageControl = UIPageControl()
        pageControl.center = CGPoint(x: UIScreen.main.bounds.width/2,
                                     y: UIScreen.main.bounds.height - 100)
        pageControl.numberOfPages = images.count
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = index
        view.addSubview(self.pageControl)

        
    }
    
       //视图显示时
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           //隐藏导航栏
           self.navigationController?.setNavigationBarHidden(true, animated: false)
       }
    
       //视图消失时
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           //显示导航栏
           self.navigationController?.setNavigationBarHidden(false, animated: false)
       }
       
       //隐藏状态栏
       override var prefersStatusBarHidden: Bool {
           return true
       }
    
    //将要对子视图布局时调用（横竖屏切换时）
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        //重新设置collectionView的尺寸
        collectionView.frame.size = self.view.bounds.size
        collectionView.collectionViewLayout.invalidateLayout()
        
        //将视图滚动到当前图片上
        let indexPath = IndexPath.init(item: self.pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
        //重新设置页控制器的位置
        pageControl.center = CGPoint(x: UIScreen.main.bounds.width/2,
                                     y: UIScreen.main.bounds.height - 100)
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




extension CJKTPhotoBrowseViewController:UICollectionViewDelegateFlowLayout, UICollectionViewDelegate ,UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CJKTPhotoBrowserCell", for: indexPath) as!CJKTPhotoBrowserCell
        
        let image = UIImage(named: self.images[indexPath.row])
        cell.imageView.image = image
        
        return cell
    }
    
    
    // return: item的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return self.view.bounds.size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    //最小列间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    
    //collectionView里某个cell将要显示
       func collectionView(_ collectionView: UICollectionView,
                           willDisplay cell: UICollectionViewCell,
                           forItemAt indexPath: IndexPath) {
           if let cell = cell as? CJKTPhotoBrowserCell{
               //由于单元格是复用的，所以要重置内部元素尺寸
               cell.resetSize()
           }
       }
       
       //collectionView里某个cell显示完毕
       func collectionView(_ collectionView: UICollectionView,
                           didEndDisplaying cell: UICollectionViewCell,
                           forItemAt indexPath: IndexPath) {
           //当前显示的单元格
           let visibleCell = collectionView.visibleCells[0]
           //设置页控制器当前页
           self.pageControl.currentPage = collectionView.indexPath(for: visibleCell)!.item
       }

}

