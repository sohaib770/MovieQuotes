//
//  ForgotPasswordViewController.m
//  GiggClone
//
//  Created by Sohaib Muhammad on 19/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "UINavigationBar+MQNavigationBar.h"
#import "Utility.h"
#import "UserService.h"
#import "MBProgressHUD.h"
#import "JBAlertView.h"
@interface ForgotPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end

@implementation ForgotPasswordViewController

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
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setLeftBarButtonItemWithTarget:self action:@selector(btnBackPressed) onNavigationBar:self.navigationItem];
    
    [self.navigationController.navigationBar setRightBarButtonItemWithTarget:self action:@selector(btnDonePressed) onNavigationBar:self.navigationItem];
    
    
    self.navigationItem.title = NSLocalizedString(@"Forgot Password", nil);
}

-(BOOL)isEachFiledValidate{
    
    BOOL result = TRUE;
    
    if(self.txtEmail.text.length == 0){
        
        
        [JBAlertView alertInView:self.mainView
                         ofStyle:JBAlertViewStyleError
                       withTitle:@"Error"
                       andDetail:@"Please enter email"
                       hideAfter:3.0];
        return FALSE;
    }
    

    if (![Utility validateEmail:self.txtEmail.text]){
        
        [JBAlertView alertInView:self.mainView
                         ofStyle:JBAlertViewStyleError
                       withTitle:@"Error"
                       andDetail:@"Invalid Email"
                       hideAfter:3.0];
        
        [self.txtEmail becomeFirstResponder];
        result = FALSE;
    }
    return result;
}

-(void)btnDonePressed{
    MBProgressHUD *hud = nil;

    if ([self isEachFiledValidate]) {
        
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [UserService forgotPasswordWithEmail:self.txtEmail.text completionBlock:^(NSError *error) {
            
            
        } errorBlock:^(NSError *error) {
            
           
        }];
        
    }
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *) event
{
    UITouch *touch = [[event allTouches] anyObject];
    if (([self.txtEmail    isFirstResponder] && (self.txtEmail != touch.view)))
        {
        [self.txtEmail resignFirstResponder];
            //  [self.txtPassword resignFirstResponder];
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

@end
