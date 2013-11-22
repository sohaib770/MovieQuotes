//
//  UINavigationBar+MQNavigationBar.h
//  GiggClone
//
//  Created by Sohaib Muhammad on 19/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (MQNavigationBar)


-(void)setLeftBarButtonItemWithTarget:(id)target action:(SEL)action onNavigationBar:(UINavigationItem *) navigationItem;

-(void)setRightBarButtonItemWithTarget:(id)target action:(SEL)action onNavigationBar:(UINavigationItem *) navigationItem;

@end
