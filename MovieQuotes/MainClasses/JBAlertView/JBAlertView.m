//
//  JBAlertView.m
//  JBAlertViewExample
//
//  Created by Jean-Baptiste Castro on 27/01/12.
//  Copyright (c) 2012 - jeanbaptistecastro.com - All rights reserved.
//

#import "JBAlertView.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

//Define time transition for showing and dismissing
#define TIME_TRANSITON 0.40

//
//Private Method
//
@interface JBAlertView()

@property (nonatomic, assign) JBAlertViewStyle style;

+ (JBAlertView*)alertView;
- (void)showTransition;

@end

//
//
//
@implementation JBAlertView

@synthesize style = alertStyle;
@synthesize alertTitle, alertDetail, alertImage, activity;

//Static jbAlert to check if alert already in view to dismiss it
static JBAlertView *jbAlert = nil;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

#pragma mark - Setter

- (void)setStyle:(JBAlertViewStyle)style
{
    if (style == JBAlertViewStyleDefault)
    {
        self.activity.hidden = YES;
        
        self.alertImage.image = [UIImage imageNamed:@"info.png"];
    }
    else if (style == JBAlertViewStyleConnection)
    {
        self.activity.hidden = NO;
        self.activity.color = [UIColor whiteColor];
        [self.activity startAnimating];
    }
    else if(style == JBAlertViewStyleError)
    {
        self.activity.hidden = YES;
        
        self.alertImage.image = [UIImage imageNamed:@"error.png"];
    }
}

#pragma mark - View methods

+ (JBAlertView*)alertInView:(UIView*)view
                    ofStyle:(JBAlertViewStyle)style
                  withTitle:(NSString*)title
                  andDetail:(NSString*)detail
                  hideAfter:(NSTimeInterval)interval
{
    //check if alert already in view to dismiss it
    if (jbAlert)
    {
        [jbAlert setHidden:YES];
        //if ([jbAlert isKindOfClass:[jbAlert class]]) {
        //            [jbAlert dismissAlert];
        ///}
        //        [];
    }
    JBAlertView *jbAlertView = [JBAlertView alertView];
    jbAlert = jbAlertView;
    
    CGRect frame = jbAlertView.alertDetail.frame;
    frame.origin.y = 8;
    jbAlertView.alertDetail.frame = frame;
    
    //If it's JBAlertViewTypeError, different background
    if (style == JBAlertViewStyleError)
        jbAlertView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.5];
    else
        jbAlertView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    
    jbAlertView.alertTitle.textColor = [UIColor whiteColor];
    
    jbAlertView.alertTitle.text = title;
    [jbAlertView.alertTitle setFont:[UIFont fontWithName:@"Roboto-Medium" size:11.0f]];
    
    jbAlertView.frame = CGRectMake(0, -50, view.bounds.size.width, 50);
    [jbAlertView setStyle:style];
    
    jbAlertView.alertTitle.hidden = YES;
    
    //Check if detail for alert
    if (detail)
    {
        jbAlertView.alertDetail.textColor = [UIColor whiteColor];
        jbAlertView.alertDetail.text = detail;
        //        [jbAlertView.alertDetail sizeToFit];
        //
        if ([jbAlertView.alertDetail.text length] > 37) {
            [jbAlertView.alertDetail setFont:[UIFont fontWithName:@"Roboto-Medium" size:11.0f]];
            [jbAlertView.alertDetail setNumberOfLines:2];
        }
    }
    else
    {
        jbAlertView.alertDetail.hidden = YES;
        jbAlertView.alertImage.frame = CGRectMake(15, 5, 35, 35);
        jbAlertView.alertTitle.frame = CGRectMake(57, 12, 240, 21);
    }
    
    //Add alert to view
    [UIView animateWithDuration:0.5 animations:^void{
        
        CGRect frames = view.frame;
        frames.origin.y = 50;
        view.frame = frames;
    }];
    
    [view addSubview:jbAlertView];
    
    //Add delay to dissmiss alert
    if (interval != 0)
        [jbAlertView performSelector:@selector(dismissAlert:) withObject:view afterDelay:interval];
    
    //Show alert in view
    return jbAlertView;
}

+ (JBAlertView*)alertInView:(UIView *)view
                    ofStyle:(JBAlertViewStyle)style
                  withTitle:(NSString *)title
                  andDetail:(NSString *)detail
                   hideWith:(SEL)selector
{
    //check if alert already in view to dismiss it
    if (jbAlert) {
        [jbAlert setHidden:YES];
        //        [jbAlert dismissAlert];
    }
    
    JBAlertView *jbAlertView = [JBAlertView alertView];
    jbAlert = jbAlertView;
    
    //If it's JBAlertViewTypeError, different background
    if (style == JBAlertViewStyleError)
        jbAlertView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.5];
    else
        jbAlertView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    
    jbAlertView.alertTitle.textColor = [UIColor whiteColor];
    jbAlertView.alertTitle.text = title;
    jbAlertView.frame = CGRectMake(0, 0, view.bounds.size.width, 50);
    [jbAlertView setStyle:style];
    
    //Check if detail for alert
    if (detail)
    {
        jbAlertView.alertDetail.textColor = [UIColor whiteColor];
        jbAlertView.alertDetail.text = detail;
        //        [jbAlertView.alertDetail sizeToFit];
        if ([jbAlertView.alertDetail.text length] > 37) {
            [jbAlertView.alertDetail setFont:[UIFont fontWithName:@"Roboto-Medium" size:11.0f]];
            [jbAlertView.alertDetail setNumberOfLines:2];
        }
        
    }
    else
    {
        jbAlertView.alertDetail.hidden = YES;
        jbAlertView.alertImage.frame = CGRectMake(15, 5, 35, 35);
        jbAlertView.alertTitle.frame = CGRectMake(57, 12, 240, 21);
    }
    
    //Add alert to view
    [view addSubview:jbAlertView];
    
    //
    //Code to dismiss alert with a define selector
    //
    
    //Show alert in view
    return jbAlertView;
}

#pragma mark - Window methods

+ (JBAlertView*)alertInWindow:(UIWindow*)window
                      ofStyle:(JBAlertViewStyle)style
                    withTitle:(NSString*)title
                    andDetail:(NSString*)detail
                    hideAfter:(NSTimeInterval)interval
{
    //check if alert already in view to dismiss it
    if (jbAlert) {
        [jbAlert setHidden:YES];
        //        [jbAlert dismissAlert];
    }
        //[jbAlert dismissAlert];
    
    
    JBAlertView *jbAlertView = [JBAlertView alertView];
    jbAlert = jbAlertView;
    
    jbAlertView = [self alertInWindow:window ofStyle:style withTitle:title andDetail:detail hideAfter:interval];
    
    //Define alert's frame
    if (![UIApplication sharedApplication].statusBarHidden) {
        CGRect frame = jbAlertView.frame;
        frame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height;
        jbAlertView.frame = frame;
    }
    
    [window addSubview:jbAlertView];
    
    if (interval != 0)
        [jbAlertView performSelector:@selector(dismissAlert:) withObject:window afterDelay:interval];
    
    //Show alert in window
    return jbAlertView;
}

+ (JBAlertView*)alertInWindow:(UIWindow *)window
                      ofStyle:(JBAlertViewStyle)style
                    withTitle:(NSString *)title
                    andDetail:(NSString *)detail
                     hideWith:(SEL)selector
{
    //check if alert already in view to dismiss it
    if (jbAlert) {
        [jbAlert setHidden:YES];
        //        [jbAlert dismissAlert];
    }
    
    
    JBAlertView *jbAlertView = [JBAlertView alertView];
    jbAlert = jbAlertView;
    
    jbAlertView = [self alertInWindow:window ofStyle:style withTitle:title andDetail:detail hideWith:selector];
    
    //Define alert's frame
    if (![UIApplication sharedApplication].statusBarHidden) {
        CGRect frame = jbAlertView.frame;
        frame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height;
        jbAlertView.frame = frame;
    }
    
    [window addSubview:jbAlertView];
    
    //
    //Code to Dismiss alert with a define selector
    //
    
    //Show alert in window
    return jbAlertView;
}

#pragma mark - Parsing the error

+(void)showError:(NSError*) error inView:(UIView*)view
{
    NSString *errorMessage = @"You are currently not able to connect to our server.  Please verify your internet connection and try again";
    
    NSDictionary *userInfo = error.userInfo;
    
    if ([userInfo objectForKey:@"short_message"])
        errorMessage = [userInfo objectForKey:@"short_message"];
    else if ([userInfo objectForKey:kMessage])
        errorMessage = [userInfo objectForKey:kMessage];
    
    [self alertInView:view
              ofStyle:JBAlertViewStyleError
            withTitle:@"Error"
            andDetail:[NSString stringWithFormat:@"%@",error]
            hideAfter:3.0];
    
    jbAlert.alertDetail.text = errorMessage;
}


#pragma mark - Touches Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //If alert is touched, it dismiss
    //  [self dismissAlert];
}

#pragma mark - Dismiss Alert

- (void)dismissTransition:(UIView*)view
{
    [UIView animateWithDuration:0.3 animations:^void{
        CGRect frame = view.frame;
        frame.origin.y = 0;
        view.frame = frame;
    }];
    
    
    
    CATransition *hideAlertTransition = [CATransition animation];
    [hideAlertTransition setDuration:TIME_TRANSITON];
    [hideAlertTransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [hideAlertTransition setType:kCATransitionPush];
    [hideAlertTransition setSubtype:kCATransitionFromTop];
    [self.layer addAnimation:hideAlertTransition forKey:nil];
    
    self.frame = CGRectMake(0, -(self.frame.size.height*2), self.frame.size.width, self.frame.size.height);
}

- (void)dismissAlert:(UIView*)view
{
    [self dismissTransition:view];
    
    //Remove alert from view
    //    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:TIME_TRANSITON];
}

#pragma mark - Pivate Method

- (void)showTransition
{
    CATransition *transition = [CATransition animation];
	transition.duration = TIME_TRANSITON;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;
	transition.subtype = kCATransitionFromBottom;
	[jbAlert.layer addAnimation:transition forKey:nil];
}

+ (JBAlertView*)alertView
{
    //Check nib file
    jbAlert =  (JBAlertView*)[[[UINib nibWithNibName:@"JBAlertView" bundle:nil]
                               instantiateWithOwner:self options:nil]
                              objectAtIndex:0];
    [jbAlert.alertDetail setFont:[UIFont fontWithName:@"Roboto-Medium" size:15.0]];
    
    [jbAlert showTransition];
    
    return jbAlert;
}

@end
