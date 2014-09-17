//
//  CHPhotoBrowserViewController.m
//  CHPhotoBrowser
//
//  Created by hangchen on 9/15/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import "CHPhotoBrowserViewController.h"
#import "UIImageView+WebCache.h"

#define kCHCollectionImageViewCell @"kCHCollectionImageViewCell"
#define kPadding 20
#define kTemporaryImageTag 1998

@implementation CHCollectionImageViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:({
            _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - kPadding, self.bounds.size.height)];
            _containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            _containerView.delegate = self;
            _containerView.minimumZoomScale = 1.0;
            _containerView.maximumZoomScale = 4.0;
            _containerView;
        })];
        
        [_containerView addSubview:({
            _imageView = [[UIImageView alloc] initWithFrame:_containerView.bounds];
            _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            _imageView.contentMode = UIViewContentModeScaleAspectFit;
            _imageView;
        })];
       
        [_containerView addGestureRecognizer:({
            UITapGestureRecognizer * doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
            doubleTapRecognizer.numberOfTapsRequired = 2;
            doubleTapRecognizer;
        })];
        
        [self addSubview:({
            MDRadialProgressTheme *newTheme = [[MDRadialProgressTheme alloc] init];
            newTheme.completedColor = [UIColor whiteColor];
            newTheme.incompletedColor = [UIColor colorWithWhite:0.75 alpha:1.0];
            newTheme.centerColor = [UIColor clearColor];
            newTheme.sliceDividerHidden = YES;
            newTheme.labelColor = [UIColor clearColor];
            newTheme.dropLabelShadow = NO;
            _progressView = [[MDRadialProgressView alloc] initWithFrame:CGRectMake((self.bounds.size.width - kPadding - 60)/2.0, (self.bounds.size.height - 60)/2.0, 60, 60) andTheme:newTheme];
            _progressView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            _progressView.progressTotal = 100;
            _progressView.progressCounter = 0;
            _progressView;
        })];

    }
    return self;
}

- (void)doubleTap:(UITapGestureRecognizer*)ges
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if( _containerView.zoomScale == _containerView.maximumZoomScale ) {
        [_containerView setZoomScale:1 animated:YES];
    }
    else {
        CGPoint touchPoint = [ges locationInView:_imageView];
        [_containerView zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    }
}

- (void)updateProgress:(CGFloat)progress
{
    if (progress >= 1) {
        _progressView.progressCounter = 0;
        _progressView.hidden = YES;
    }
    else {
        _progressView.progressCounter = _progressView.progressTotal* progress;
        _progressView.hidden = NO;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
@end


@implementation CHPhotoBrowserViewController {
    NSArray *images_;
    CGPoint contentOffsetAfterRotation_;
}

- (instancetype)initWithImages:(NSArray*)images
{
    if (self = [super init]) {
        images_ = [NSArray arrayWithArray:images];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.view addSubview:({
        _collectionFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionFlowLayout.minimumInteritemSpacing = 0;
        _collectionFlowLayout.minimumLineSpacing = 0;
        _collectionFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width + kPadding, self.view.bounds.size.height) collectionViewLayout:_collectionFlowLayout];
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:CHCollectionImageViewCell.class forCellWithReuseIdentifier:kCHCollectionImageViewCell];
        _collectionView;
    })];
    
    [self.view addSubview:({
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 150)/2.0, self.view.bounds.size.height - 30, 150, 20)];
        _pageControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        _pageControl.numberOfPages = images_.count;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.75 alpha:1.0];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl;
    })];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width + kPadding, self.view.bounds.size.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return images_.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageAddress = images_[indexPath.item];
    CHCollectionImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCHCollectionImageViewCell forIndexPath:indexPath];
    cell.containerView.zoomScale = 1.0;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageAddress] placeholderImage:[UIImage imageNamed:@"default_pic.png"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [cell updateProgress:(CGFloat)receivedSize/expectedSize];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.progressView.hidden = YES;
        if (error) {
            cell.imageView.image = [UIImage imageNamed:@"fail_pic.png"];
        }
    }];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width + kPadding;
    _pageControl.currentPage = index;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if ((UIInterfaceOrientationIsLandscape(self.interfaceOrientation) && UIInterfaceOrientationIsPortrait(toInterfaceOrientation))  || (UIInterfaceOrientationIsPortrait(self.interfaceOrientation) && UIInterfaceOrientationIsLandscape(toInterfaceOrientation))) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] firstObject];
        CHCollectionImageViewCell *cell = (id)[self.collectionView cellForItemAtIndexPath:indexPath];
        [self.view insertSubview:({
            UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.imageView.image];
            imageView.frame = self.view.bounds;
            imageView.tag = kTemporaryImageTag;
            imageView.backgroundColor = [UIColor blackColor];
            imageView.contentMode= cell.imageView.contentMode;
            imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            imageView;
        }) aboveSubview:self.collectionView];
        
        contentOffsetAfterRotation_ = CGPointMake(indexPath.item * (self.view.bounds.size.height  + kPadding), 0);
    }
    else {
        contentOffsetAfterRotation_ = self.collectionView.contentOffset;
    }
    [self.collectionFlowLayout invalidateLayout];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.collectionView setContentOffset:contentOffsetAfterRotation_];
    [[self.view viewWithTag:kTemporaryImageTag] removeFromSuperview];
}
@end