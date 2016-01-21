# CarouselBannerView

1、在ViewController 里创建CarouselBannerView
```
class ViewController: UIViewController,CarouselBannerViewDelegate {
   var bannerView = CarouselBannerView()
   var imageSource = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bannerView = CarouselBannerView.init(frame: CGRectMake(0, 0, 320, 160))
        self.bannerView.bannerDelegate = self
        self.view.addSubview(self.bannerView)
        
       
        //网络图片地址数组
         imageSource = NSArray.init(objects: "http://static.damai.cn/cfs/2015/12/1ab03ad9-fcab-4806-b2a9-56e111bcde1f.jpg","http://static.dmcdn.cn/cfs/2016/1/86cb20f1-ec19-451a-975c-9123a92b1b16.jpg","http://static.dmcdn.cn/cfs/2015/12/f1f88dd4-493f-43d0-9f67-a62c4ce70d54.jpg","http://pimg.damai.cn/perform/damai/NewIndexManagement/201601/e0cbde39ecc94a4986e9ed8f6b2767e8.jpg")
       // 3秒后刷新数据
        self.performSelector(Selector("fetchData"), withObject:nil, afterDelay: 3)
    }
    func fetchData(){
   
     self.bannerView .reloadData()
    }
}
```
2、引入需要实现3个协议
```
      //获取图片的image（用的第三方的Kingfisher 加载的网络图片）
     func scrollView(toScrollView scrollView: CarouselBannerView, andImageAtIndex index: NSInteger, forImageView imageView: UIImageView) {
 
        imageView.kf_setImageWithURL(NSURL(string: imageSource.objectAtIndex(index) as! String)!, placeholderImage: UIImage.init(named: "banner_bgImage"))
     }
     //返回图片个数
    func numberOfImageInScrollView(toScrollView scrollView: CarouselBannerView) -> Int {
        return imageSource.count
    }
    //图片点击事件
    func  scrollView ( toScrollView scrollView : CarouselBannerView, didTappedImageAtIndex  index : NSInteger){
     print("点击\(index)")
    }
```
