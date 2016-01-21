//
//  ViewController.swift
//  CarouselBanner
//
//  Created by chenhongsong on 16/1/19.
//  Copyright © 2016年 KaFa. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CarouselBannerViewDelegate {
   var bannerView = CarouselBannerView()
   var imageSource = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bannerView = CarouselBannerView.init(frame: CGRectMake(0, 0, 320, 160))
        self.view.addSubview(self.bannerView)
        self.bannerView.bannerDelegate = self
        self.performSelector(Selector("fetchData"), withObject:nil, afterDelay: 4)
         imageSource = NSArray.init(objects: "http://static.damai.cn/cfs/2015/12/1ab03ad9-fcab-4806-b2a9-56e111bcde1f.jpg","http://static.dmcdn.cn/cfs/2016/1/86cb20f1-ec19-451a-975c-9123a92b1b16.jpg","http://static.dmcdn.cn/cfs/2015/12/f1f88dd4-493f-43d0-9f67-a62c4ce70d54.jpg","http://pimg.damai.cn/perform/damai/NewIndexManagement/201601/e0cbde39ecc94a4986e9ed8f6b2767e8.jpg")
        // Do any additional setup after loading the view, typically from a nib.
    }
    func fetchData(){
   
     self.bannerView .reloadData()
    }
    func scrollView(toScrollView scrollView: CarouselBannerView, andImageAtIndex index: NSInteger, forImageView imageView: UIImageView) {
 
        imageView.kf_setImageWithURL(NSURL(string: imageSource.objectAtIndex(index) as! String)!, placeholderImage: UIImage.init(named: "banner_bgImage"))
     }
    func  scrollView ( toScrollViww scrollView : CarouselBannerView , didDidScrollToPage page : NSInteger)
    {
        
    }
    func numberOfImageInScrollView(toScrollView scrollView: CarouselBannerView) -> Int {
        return imageSource.count
    }
    func  scrollView ( toScrollView scrollView : CarouselBannerView, didTappedImageAtIndex  index : NSInteger){
     print("点击\(index)")
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

