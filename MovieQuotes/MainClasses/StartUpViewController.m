//
//  StartUpViewController.m
//  GiggClone
//
//  Created by Sohaib Muhammad on 01/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import "StartUpViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface StartUpViewController ()
- (IBAction)btnLoginPressed:(UIButton *)sender;
- (IBAction)btnGetStartedPressed:(UIButton *)sender;

@end

@implementation StartUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}

- (IBAction)btnLoginPressed:(UIButton *)sender {
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    [self.navigationController pushViewController:loginViewController animated:YES];
    
}

- (IBAction)btnGetStartedPressed:(UIButton *)sender {
    RegisterViewController *registerViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    
    [self.navigationController pushViewController:registerViewController animated:YES];
}
@end
