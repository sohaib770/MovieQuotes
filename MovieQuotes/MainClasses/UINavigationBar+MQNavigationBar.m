//
//  UINavigationBar+MQNavigationBar.m
//  GiggClone
//
//  Created by Sohaib Muhammad on 19/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import "UINavigationBar+MQNavigationBar.h"

@implementation UINavigationBar (MQNavigationBar)

-(void)setLeftBarButtonItemWithTarget:(id)target action:(SEL)action onNavigationBar:(UINavigationItem *) navigationItem{
      UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back.png"] style:UIBarButtonItemStylePlain target:target action:action];
    navigationItem.leftBarButtonItem = btnBack;

}

-(void)setRightBarButtonItemWithTarget:(id)target action:(SEL)action onNavigationBar:(UINavigationItem *) navigationItem{
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_ok.png"] style:UIBarButtonItemStylePlain target:target action:action];
    navigationItem.rightBarButtonItem = btnDone;
}

@end
