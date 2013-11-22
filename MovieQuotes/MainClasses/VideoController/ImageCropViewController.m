//
//  ImageCropViewController.m
//  TopBlip
//
//  Created by Avantar Developer on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageCropViewController.h"
#import "UIImage+Resize.h"
#import <QuartzCore/QuartzCore.h>

#define SIDE_MARGIN  20

#define BORDER_WHITE    0.0
#define BORDER_OPACITY  0.7

@interface ImageCropViewController ()

@end

@implementation ImageCropViewController
int trigger = 0;
int iphone4Camera = 0;

+(id)viewControllerWithImage:(UIImage*)image{
    ImageCropViewController *result = [[ImageCropViewController alloc] init];
    
    [result view];
    iphone4Camera = 0;
    result.image = image;
    
    return result;
}

-(void)modifyBorderLayer{
    
}

-(void)loadView
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    int yPoint = 0;
    
    NSArray *vComp = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[vComp objectAtIndex:0] intValue] >= 7) {
        yPoint = -23;
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIView *rootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-108)];
    rootView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-108)];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    
    _scrollView.maximumZoomScale = 4.0;
    _scrollView.minimumZoomScale = 0.25;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor blackColor];
    
    [rootView addSubview:_scrollView];
    
    UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(0, yPoint, screenWidth, screenHeight)];
    if ([UIScreen mainScreen].bounds.size.height == 568)
        mask.image = [UIImage imageNamed:@"camera_mask"];
    else
        mask.image = [UIImage imageNamed:@"camera_mask_4"];
    
    mask.alpha = 0.5;
    [rootView addSubview:mask];
    
    _imageView = [[UIImageView alloc] init];
    [_scrollView addSubview:_imageView];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, screenHeight-152, 320, 44)];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleTopMargin  |
    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *crop = [[UIBarButtonItem alloc] initWithTitle:@"Crop" style:UIBarButtonItemStyleDone target:self action:@selector(crop:)];
    
    toolbar.items = [NSArray arrayWithObjects:cancel, space, crop, nil];
    
    
    [rootView addSubview:toolbar];
    
    self.view = rootView;
    [rootView bringSubviewToFront:toolbar];
    self.view.backgroundColor = [UIColor blackColor];
    
}

-(void)layerPass:(CALayer*)newLayer{
    newLayer.borderColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0].CGColor;
    newLayer.borderWidth = 1.0;
}

-(void)adjustScrollView
{
    UIEdgeInsets insets;
    
    insets.bottom = insets.top = _cropRect.origin.y;
    insets.right = insets.left = _cropRect.origin.x;
    
    _scrollView.contentInset = insets;
}

-(void)calcCropRect
{
    NSArray *vComp = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[vComp objectAtIndex:0] intValue] >= 7) {
//        _cropRect.origin.y = 20;
    }
    
    _cropRect.size = _cropSize;
    CGSize viewSize = _scrollView.frame.size;
    
    CGFloat widthRatio = viewSize.width / _cropSize.width;
    CGFloat heightRatio = viewSize.height / _cropSize.height;
    
    if (widthRatio < heightRatio)
    {
        CGFloat width = viewSize.width - SIDE_MARGIN * 2;
        _cropRect.size = CGSizeMake(width, width * _cropSize.height / _cropSize.width);
    }
    else
    {
        CGFloat height = viewSize.height - SIDE_MARGIN * 2;
        _cropRect.size = CGSizeMake(height * _cropSize.width / _cropSize.height, height);
    }
    
    _cropRect.origin = CGPointMake((viewSize.width - _cropRect.size.width) * 0.5, (viewSize.height - _cropRect.size.height) * 0.5);
    
    widthRatio = _imageView.image.size.width / _cropSize.width;
    heightRatio = _imageView.image.size.height / _cropSize.height;
    
    _scrollView.maximumZoomScale = MAX(widthRatio, heightRatio);
    _scrollView.minimumZoomScale = MAX(_cropRect.size.width / _imageView.image.size.width, _cropRect.size.height / _imageView.image.size.height);
    
    if (_scrollView.minimumZoomScale > _scrollView.maximumZoomScale)
        _scrollView.maximumZoomScale = _scrollView.minimumZoomScale;
    
    _scrollView.zoomScale = _scrollView.minimumZoomScale;
    
    [self adjustScrollView];
}

-(void)viewDidLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self calcCropRect];
}

-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewDidUnload{
    [self setDelegate:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}

#pragma mark IBActions

-(IBAction)cancel:(id)sender
{
    [[UIApplication sharedApplication] setStatusBarHidden:FALSE withAnimation:UIStatusBarAnimationSlide];
    [_delegate imageCropCancelled:self];
}

-(IBAction)crop:(id)sender
{
    CGRect cropRect = [_imageView convertRect:_cropRect fromView:self.view];
//    cropRect.origin.y+=160;
    UIImage *cropResult = [_imageView.image croppedImage:cropRect];
    
    if (_cropRect.size.width > _cropSize.width || _cropRect.size.height > _cropSize.height)
    {
        cropResult = [cropResult resizedImage:_cropSize interpolationQuality:kCGInterpolationHigh];
    }
    [[UIApplication sharedApplication] setStatusBarHidden:FALSE withAnimation:UIStatusBarAnimationSlide];
    
//    [self performSelectorInBackground:@selector(savePhoto:) withObject:cropResult];
    
    [_delegate imageCrop:self didCropImage:cropResult];
}

- (void) savePhoto:(UIImage*)image {
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

#pragma mark Properties

@synthesize delegate = _delegate;
@dynamic image;
@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;
@synthesize cropSize = _cropSize;

-(void)setCropSize:(CGSize)cropSize
{
    _cropSize = cropSize;
    
    [self calcCropRect];
}

-(UIImage*)image
{
    return _imageView.image;
}

-(void)setImage:(UIImage *)image
{
    
    _imageView.image = image;
    _imageView.frame = CGRectMake(  0, 0, image.size.width, image.size.height);
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _scrollView.contentSize = image.size;
}

#pragma mark UIScrollViewDelegate

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

@end
