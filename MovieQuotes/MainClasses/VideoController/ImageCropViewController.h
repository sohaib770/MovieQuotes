//
//  ImageCropViewController.h
//  TopBlip
//
//  Created by Avantar Developer on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageCropViewController;

@protocol ImageCropViewControllerDelegate <NSObject>

-(void)imageCrop:(ImageCropViewController*)imageCrop didCropImage:(UIImage*)croppedImage;
-(void)imageCropCancelled:(ImageCropViewController*)imageCrop;

@end

@interface ImageCropViewController : UIViewController <UIScrollViewDelegate>
{
    id<ImageCropViewControllerDelegate> __weak _delegate;
    
    UIScrollView *_scrollView;
    UIImageView *_imageView;
    
    CGSize _cropSize;
    CGRect _cropRect;
    
    UIView *_topBorder;
    UIView *_bottomBorder;
    UIView *_rightBorder;
    UIView *_leftBorder;
}

@property (nonatomic, readwrite, weak) id<ImageCropViewControllerDelegate> delegate;

@property (nonatomic, readwrite, strong) UIImage *image;

@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
@property (nonatomic, readwrite, strong) UIImageView *imageView;
@property (nonatomic, readwrite, strong) UIView *border;

@property (nonatomic, readwrite, assign) CGSize cropSize;

+(id)viewControllerWithImage:(UIImage*)image;
-(void)layerPass:(CALayer*)newLayer;

@end
