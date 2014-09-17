//
//  CHPhotoBrowserViewController.h
//  CHPhotoBrowser
//
//  Created by hangchen on 9/15/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHPhotoBrowserViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,readonly)UICollectionView *collectionView;
@property(nonatomic,readonly)UICollectionViewFlowLayout *collectionFlowLayout;
@property(nonatomic,readonly)UIPageControl *pageControl;
- (instancetype)initWithImages:(NSArray*)images;
@end
