//
//  CHPhotoBrowserViewController.h
//  CHPhotoBrowser
//
//  Created by hangchen on 9/15/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"

@interface CHPhotoBrowserViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,readonly)UICollectionView *collectionView;
@property(nonatomic,readonly)UICollectionViewFlowLayout *collectionFlowLayout;
- (instancetype)initWithImages:(NSArray*)images;
@end

@interface CHCollectionImageViewCell : UICollectionViewCell<UIScrollViewDelegate>
@property(nonatomic,readonly)UIScrollView *containerView;
@property(nonatomic,readonly)UIImageView* imageView;
@property(nonatomic,readonly)MDRadialProgressView *progressView;
- (void)updateProgress:(CGFloat)progress;
@end