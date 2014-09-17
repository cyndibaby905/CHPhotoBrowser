## CHPhotoBrowser ##

_A photo browser for humans_

##### Simple...

-   100 lines of Objective-C you can understand
-   runs on iOS 6+
-   just drag and drop .h and .m in your project
-   MIT license

##### ... yet powerful

-   smooth animations
-   memory saving
-   diplay both remote images and local images(Assets Library or local path) as well



## Requirements ##

`CHPhotoBrowser` requires:
-   Xcode 5 and above, targeting either iOS 6.0 and above, ARC-enabled
-   [SDWebImage](https://github.com/rs/SDWebImage)
-   [MDRadialProgress](https://github.com/mdinacci/MDRadialProgress)


### Install

    $ git clone https://github.com/cyndibaby905/CHPhotoBrowser.git
    $ cd CHPhotoBrowser
    $ git submodule init
    $ git submodule update



 
## How to use ##


    #import "CHPhotoBrowserViewController.h"

    NSArray *remoteImages = @[@"http://mg.soupingguo.com/bizhi/big/10/273/104/10273104.jpg",
                              @"http://cdn.duitang.com/uploads/item/201310/10/20131010184344_wQhKC.jpeg",
                              @"http://cdn.duitang.com/uploads/item/201304/27/20130427014412_KU2jV.jpeg",
                              @"http://apple.xdnice.com/uploads/allimg/121009/10144S355-0.jpg",
                              @"http://apple.xdnice.com/uploads/allimg/121106/12233610J-0.jpg",
                              @"http://cdn.duitang.com/uploads/item/201306/24/20130624132605_eBKVA.jpeg",
                              @"http://img2.duitang.com/uploads/item/201304/27/20130427021414_YQE2w.jpeg",
                              @"http://img4.duitang.com/uploads/item/201304/27/20130427014742_aFFaw.jpeg",
                              @"http://cdn.duitang.com/uploads/item/201304/27/20130427012418_HehyL.jpeg",
                              @"http://apple.xdnice.com/uploads/allimg/121106/12204K313-0.jpg"];
        
    CHPhotoBrowserViewController *photoVC = [[CHPhotoBrowserViewController alloc] initWithImages:remoteImages]; 
    [self presentViewController:photoVC animated:YES completion:nil];


## How it looks ##

![CHPhotoBrowser] (https://raw.github.com/cyndibaby905/CHPhotoBrowser/master/demo.gif)