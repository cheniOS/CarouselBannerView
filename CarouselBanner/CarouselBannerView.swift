//
//  CarouselBannerView.swift
//  CarouselBanner
//
//  Created by chenhongsong on 16/1/19.
//  Copyright © 2016年 KaFa. All rights reserved.
//

import UIKit
import Kingfisher
protocol CarouselBannerViewDelegate  : NSObjectProtocol{
    func  numberOfImageInScrollView (toScrollView scrollView : CarouselBannerView) ->Int
    func  scrollView ( toScrollView scrollView : CarouselBannerView ,andImageAtIndex  index: NSInteger ,  forImageView  imageView : UIImageView)
    
    func  scrollView ( toScrollView scrollView : CarouselBannerView, didTappedImageAtIndex  index : NSInteger)
     func  scrollView ( toScrollViww scrollView : CarouselBannerView , didDidScrollToPage page : NSInteger)
}
class CarouselBannerView: UIView ,UIScrollViewDelegate,UIGestureRecognizerDelegate  {
    var bannerDelegate  : CarouselBannerViewDelegate!
    var bgScrollView = UIScrollView()
    var imageView1 = UIImageView()
    var imageView2 = UIImageView()
    var imageView3 = UIImageView()
    var pageControl = UIPageControl()
    var numberForImage = Int()
    var scrollTimer = NSTimer()
    var currentPage = NSInteger()
    var shouldAutoScoll = Bool()
    var scrollInterval  = NSTimeInterval()
    var isInitLayoutSubVies = Bool()
   override init(frame: CGRect) {
        super.init(frame: frame);
     self.bgScrollView = UIScrollView.init(frame: CGRectMake(0, 0, self.frame.width, self.frame.height))
        self.bgScrollView .pagingEnabled = true
        self.bgScrollView .showsHorizontalScrollIndicator = true
        self.bgScrollView .showsVerticalScrollIndicator = true
        self.addSubview(self.bgScrollView)
        self.setUpInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpInit (){
      self.bgScrollView.delegate = self
    self.shouldAutoScoll   = true;
//      self.backgroundColor = UIColor.blueColor()
      self.numberForImage = 1
      self.scrollInterval = 5
      self.imageView1 = UIImageView.init(frame:self.bounds)
      self.imageView1.backgroundColor=UIColor.redColor()
      self.imageView2 = UIImageView.init(frame:self.bounds)
      self.imageView2.backgroundColor=UIColor.greenColor()
      self.imageView3 = UIImageView.init(frame:self.bounds)
      self.imageView3.backgroundColor=UIColor.blueColor()
        imageView1.clipsToBounds = true
        imageView2.clipsToBounds = true
        imageView3.clipsToBounds = true
        self.bgScrollView.addSubview(imageView1)
        self.bgScrollView.addSubview(imageView2)
        self.bgScrollView.addSubview(imageView3)
        
        self.imageView2.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("toTapImageView:"))
        self.imageView2.addGestureRecognizer(tapGesture)
        
        self.pageControl = UIPageControl.init(frame: CGRectMake((self.frame.size.width - 200)/2,self.frame.size.height-30, 200, 20))
//        self.pageControl.numberOfPages = 4
        self.addSubview(self.pageControl)
     
//        self.bringSubviewToFront(self.pageControl)
    }
    
 
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if(self.shouldAutoScoll){
            self.setUpAutoScrollTimer()
        }
    }
    
    func toTapImageView ( gesture : UITapGestureRecognizer){
        self.bannerDelegate?.scrollView(toScrollView: self, didTappedImageAtIndex: self.currentPage)
    }
    
    func setUpAutoScrollTimer(){
    if (!self.scrollTimer.valid) {
        self.scrollTimer = NSTimer(timeInterval: self.scrollInterval, target: self, selector: Selector("autoScrollTimerFired:"), userInfo:nil , repeats: true)
        NSRunLoop .currentRunLoop().addTimer(self.scrollTimer, forMode: NSRunLoopCommonModes)
     }
}
  
    func autoScrollTimerFired (time : NSTimer){
        UIView.animateWithDuration(0.5, animations:{
            self.bgScrollView.contentOffset =  CGPointMake(2 * self.bounds.size.width, 0)} , completion:{finshed  in  self.scrollViewDidEndDecelerating(self.bgScrollView)
        })
    }
    
    override func layoutSubviews() {
        if (!isInitLayoutSubVies){
           
            self.bgScrollView.contentOffset    = CGPointMake(self.frame.size.width, 0)
            self.imageView1.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
            self.imageView2.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width,self.frame.size.height )
            self.imageView3.frame = CGRectMake(self.frame.size.width*2, 0, self.frame.size.width, self.frame.size.height)
            self.bgScrollView.contentSize = CGSizeMake(3*self.frame.size.width, self.frame.size.height)
            isInitLayoutSubVies = true
             self.reloadIamge()
        }
        super.layoutSubviews()
    }
    
    func reloadIamge(){
        self.pageControl.currentPage = self.currentPage
        self.bannerDelegate!.scrollView(toScrollView: self, andImageAtIndex: self.currentPage, forImageView: self.imageView2)
        self.bannerDelegate!.scrollView(toScrollView: self, andImageAtIndex: self.currentPage == (self.numberForImage - 1) ? 0 : self.currentPage + 1 , forImageView: self.imageView3)
        self.bannerDelegate?.scrollView(toScrollView: self, andImageAtIndex: self.currentPage == 0 ? (self.numberForImage - 1) : self.currentPage - 1, forImageView: self.imageView1)
//    func  scrollView ( toScrollViww scrollView : CarouselBannerView , didDidScrollToPage page : NSInteger)
     self.bannerDelegate?.scrollView(toScrollViww: self, didDidScrollToPage: self.currentPage)
    }
   //MARK:  scrollViewDelegate
    
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(self.shouldAutoScoll){
            self.setUpAutoScrollTimer()
        }
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.scrollTimer.invalidate()
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let  contentOffsetX : CGFloat  = self.bgScrollView.contentOffset.x
        let  pageNumber   =  Int(contentOffsetX / CGRectGetWidth(self.frame))
        if (pageNumber == 0){
            self.currentPage = self.currentPage == 0 ? (self.numberForImage-1) : self.currentPage - 1
        }
        else if (pageNumber == 2){
            self.currentPage = self.currentPage == (self.numberForImage - 1) ? 0 : self.currentPage + 1
        }
        
        self.reloadIamge()
        self.bgScrollView.contentOffset = CGPointMake(self.bounds.size.width, 0)
        
    }
    func  reloadData() {
        let cout : Int = self.bannerDelegate.numberOfImageInScrollView(toScrollView: self)
//        let cout : Int
       self.numberForImage = cout
        self.pageControl.numberOfPages = self.numberForImage
    }
    
    //MARK: 懒加载处理
//    lazy var scrollInterval : NSTimeInterval = {
//        
//        return 1
//    }()
    
    
}
