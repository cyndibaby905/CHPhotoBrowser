//
//  CHViewController.m
//  MultiDemo
//
//  Created by hangchen on 9/15/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import "CHViewController.h"

#define kCHCollectionViewCell @"kCHCollectionViewCell"
#define kPadding 20

@interface CHCollectionViewCell : UICollectionViewCell<UIScrollViewDelegate>
@property(nonatomic,readonly)UIScrollView *containerView;
@property(nonatomic,readonly)UIImageView* imageView;
@end


@implementation CHCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - kPadding, self.bounds.size.height)];
        _containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
        _containerView.delegate = self;
        _containerView.minimumZoomScale = 1.0;
        _containerView.maximumZoomScale = 4.0;
        [self addSubview:_containerView];
        
        _imageView = [[UIImageView alloc] initWithFrame:_containerView.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_containerView addSubview:_imageView];
       
        
        UITapGestureRecognizer * doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        [_containerView addGestureRecognizer:doubleTapRecognizer];

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

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}


@end


@implementation CHViewController
{
    NSArray *images_;
}

- (instancetype)initWithImages:(NSArray*)images
{
    self = [super init];
    if (self) {
        images_ = [NSArray arrayWithArray:images];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
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

    [self.view addSubview:_collectionView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 150)/2.0, self.view.bounds.size.height - 30, 150, 20)];
    _pageControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _pageControl.numberOfPages = images_.count;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:_pageControl];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:CHCollectionViewCell.class forCellWithReuseIdentifier:kCHCollectionViewCell];
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
    
    CHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCHCollectionViewCell forIndexPath:indexPath];
    cell.containerView.zoomScale = 1.0;
    cell.imageView.image = [UIImage imageNamed:images_[indexPath.item]];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / (self.view.bounds.size.width + kPadding);
    _pageControl.currentPage = index;
}
@end
