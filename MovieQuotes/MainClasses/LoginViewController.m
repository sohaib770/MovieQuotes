//
//  LoginViewController.m
//  GiggClone
//
//  Created by Sohaib Muhammad on 01/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgotPasswordViewController.h"
#import "UserService.h"
#import "UINavigationBar+MQNavigationBar.h"
#import "JBAlertView.h"
#import "Utility.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;

@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)btnForgotPasswordPressed:(UIButton *)sender;
- (IBAction)btnResetPasswordPressed:(UIButton *)sender;

@end

@implementation LoginViewController

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
    
    [self.navigationController.navigationBar setHidden:NO];
    
    [self.navigationController.navigationBar setLeftBarButtonItemWithTarget:self action:@selector(btnBackPressed) onNavigationBar:self.navigationItem];
 
    [self.navigationController.navigationBar setRightBarButtonItemWithTarget:self action:@selector(btnDonePressed) onNavigationBar:self.navigationItem];
    
    self.navigationItem.title = NSLocalizedString(@"SignIn", nil);
}

-(void)btnDonePressed{
    if([self validateInputFields]){

        [UserService loginUserWithUsername:self.txtEmail.text andPassword:self.txtPassword.text completionBlock:^(UserDetails *userDetails) {
            
        } errorBlock:^(NSError *error) {
            
        }];
        
    }

    
}
-(void)btnBackPressed{
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)validateInputFields
{
    
    if(self.txtEmail.text.length == 0){
        
        
        [JBAlertView alertInView:self.mainView
                         ofStyle:JBAlertViewStyleError
                       withTitle:@"Error"
                       andDetail:@"Please enter email or username"
                       hideAfter:3.0];
        [self.txtEmail resignFirstResponder];
        return FALSE;
    }
    
    if (self.txtPassword.text.length == 0)
        {
        
        [JBAlertView alertInView:self.mainView
                         ofStyle:JBAlertViewStyleError
                       withTitle:@"Error"
                       andDetail:@"Please enter your password"
                       hideAfter:3.0];
        [self.txtPassword resignFirstResponder];
        return FALSE;
        }
    
    return TRUE;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *) event
{
    UITouch *touch = [[event allTouches] anyObject];
    if (([self.txtEmail    isFirstResponder] && (self.txtEmail != touch.view)) ||
        ([self.txtPassword isFirstResponder] && (self.txtPassword != touch.view)))
        {
            [self.txtEmail resignFirstResponder];
            [self.txtPassword resignFirstResponder];
        }
}


- (IBAction)btnForgotPasswordPressed:(UIButton *)sender {
    ForgotPasswordViewController *forgotPasswordViewController = [[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:forgotPasswordViewController animated:YES];
}

- (IBAction)btnResetPasswordPressed:(UIButton *)sender {
    
    
}
@end
