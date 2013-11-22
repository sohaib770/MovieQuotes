//
//  RegisterViewController.m
//  GiggClone
//
//  Created by Sohaib Muhammad on 19/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import "RegisterViewController.h"
#import "UINavigationBar+MQNavigationBar.h"
#import "FacebookManager.h"
#import "BSKeyboardControls.h"
#import "FBUser.h"
#import "MBProgressHUD.h"
#import "FBPermssionConstants.h"
#import "JBAlertView.h"
#import "Utility.h"
#import "UserService.h"
#define ALPHA   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
#define MAX_USERNAME_LENGTH     15
#define MIN_USERNAME_LENGTH     4
#define MIN_PASSWORD_LENGTH     2

@interface RegisterViewController ()<UITextFieldDelegate,BSKeyboardControlsDelegate>

@property (weak, nonatomic)     IBOutlet UIView *alertView;
@property (weak, nonatomic)     IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic)     IBOutlet UIView *mainView;
@property (nonatomic, strong)   IBOutlet UITextField *txtEmail;
@property (nonatomic, strong)   IBOutlet UITextField *txtPassword;
@property (nonatomic, strong)   IBOutlet UITextField *txtUsername;
@property (nonatomic, strong)   IBOutlet UITextField *txtName;
@property (nonatomic, strong)   IBOutlet UIImageView *imgProfilePic;
@property (nonatomic, strong)   FacebookManager *fbManager;
@property (nonatomic, strong)   BSKeyboardControls *keyboardControls;

-(IBAction)btnUseFacebookInfoPressed:(UIButton *)sender;

@end

@implementation RegisterViewController

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
    
    NSLog(@" Start ContentOffSet== > %@",NSStringFromCGPoint(self.scrollView.contentOffset));
    NSLog(@" Strat ContentSize == > %@",NSStringFromCGSize(self.scrollView.contentSize));
    
        // [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHue:0.555f saturation:1.f brightness:0.855f alpha:1.f]];
         
    [self.navigationController.navigationBar setLeftBarButtonItemWithTarget:self action:@selector(btnBackPressed) onNavigationBar:self.navigationItem];
    
    [self.navigationController.navigationBar setRightBarButtonItemWithTarget:self action:@selector(btnDonePressed) onNavigationBar:self.navigationItem];
    
    self.navigationItem.title = NSLocalizedString(@"Registration", nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.view addSubview:self.alertView];
    [self.view bringSubviewToFront:self.alertView];
       
    [self.navigationController.navigationBar setHidden:NO];
    NSArray *fields = @[self.txtUsername,self.txtPassword,self.txtEmail,self.txtName];
    [self setKeyboardControls : [[BSKeyboardControls alloc] initWithFields : fields]];
    [self.keyboardControls setDelegate : self];
    self.txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
    self.txtName.keyboardType = UIKeyboardTypeDefault;
    self.txtUsername.keyboardType = UIKeyboardTypeDefault;
    self.txtPassword.keyboardType = UIKeyboardTypeDefault;

}
-(void)btnDonePressed{
    
    if ([self isEachFieldValidate] ) {
     
      [UserService registerUserWithUsername:self.txtUsername.text name:self.txtName.text emailAddress:self.txtEmail.text profilePicutre:nil password:self.txtPassword.text completionBlock:^(NSError *error) {
          
      } errorBlock:^(NSError *error) {
          
      }];
        
    }
}
-(void)btnBackPressed{
    
    [self.fbManager closeSession];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(BOOL)isEachFieldValidate
{
  
    
    if (self.txtUsername.text.length == 0)
        {
        
        [JBAlertView alertInView:self.mainView
                         ofStyle:JBAlertViewStyleError
                       withTitle:@"Error"
                       andDetail:@"Enter a username"
                       hideAfter:3.0];
        [self.txtUsername becomeFirstResponder];
        return FALSE;
        }
    
    if (self.txtUsername.text.length > MAX_USERNAME_LENGTH)
        {
        
        [JBAlertView alertInView:self.mainView
                         ofStyle:JBAlertViewStyleError
                       withTitle:@"Error"
                       andDetail:@"Username must not exceed 15 characters"
                       hideAfter:3.0];
        [self.txtUsername becomeFirstResponder];
        return FALSE;
        }
    
    if (self.txtUsername.text.length < MIN_USERNAME_LENGTH)
        {
        
        [JBAlertView alertInView:self.alertView
                         ofStyle:JBAlertViewStyleError
                       withTitle:@"Error"
                       andDetail:@"Username must be atleast 4 characters long"
                       hideAfter:3.0];
        [self.txtUsername becomeFirstResponder];
        return FALSE;
        }
    
    if (self.txtPassword.text.length < MIN_PASSWORD_LENGTH)
        {
        
        [JBAlertView alertInView:self.mainView
                         ofStyle:JBAlertViewStyleError
                       withTitle:@"Error"
                       andDetail:@"Password must be atleast 2 characters long"
                       hideAfter:3.0];
        [self.txtPassword becomeFirstResponder];
        return FALSE;
        }
    
    if (![Utility validateEmail:self.txtEmail.text])
        {
        
        [JBAlertView alertInView:self.alertView
                         ofStyle:JBAlertViewStyleError
                       withTitle:@"Error"
                       andDetail:@"Invalid Email"
                       hideAfter:3.0];
              [self.txtEmail becomeFirstResponder];
        return FALSE;
        }
    
    
    
    else if (self.txtPassword.text.length > MAX_USERNAME_LENGTH)
        {
        
        [JBAlertView alertInView:self.mainView
                         ofStyle:JBAlertViewStyleError
                       withTitle:@"Error"
                       andDetail:@"Password must not exceed 15 characters"
                       hideAfter:3.0];
        [self.txtPassword becomeFirstResponder];
        return FALSE;
        }
    
    
    if (self.txtName.text.length == 0)
        {
        
        [JBAlertView alertInView:self.mainView
                         ofStyle:JBAlertViewStyleError
                       withTitle:@"Error"
                       andDetail:@"Please enter your name."
                       hideAfter:3.0];
        [self.txtName becomeFirstResponder];
        return FALSE;
        }
    
    return TRUE;
}
- (void) resetFrame
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
     NSLog(@" Before  == > %@",NSStringFromCGPoint(self.scrollView.contentOffset));
    NSLog(@" Before == > %@",NSStringFromCGSize(self.scrollView.contentSize));
    
         self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, screenHeight-64);
    
    NSLog(@" After  == > %@",NSStringFromCGSize(self.scrollView.contentSize));

    
         [self.scrollView setContentOffset : CGPointMake(self.scrollView.frame.origin.x, 0)
                    animated         : YES];
    
     NSLog(@" After  == > %@",NSStringFromCGPoint(self.scrollView.contentOffset));
    [UIView commitAnimations];
}

- (void) moveView:(CGRect)frame
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    float distanceFromTop = screenHeight - 390;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
         self.scrollView.contentOffset = CGPointMake(self.mainView.frame.origin.x, frame.origin.y-distanceFromTop);
    
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark - BSKeyboardControls methods

-(void) keyboardControls:(BSKeyboardControls *) keyboardControls selectedField: (UIView *)field
         inDirection: (BSKeyboardControlsDirection) direction{
    
    UITextField *textField = (UITextField*)keyboardControls.activeField;
    
    if (textField == self.txtPassword)
        {
            if (direction == BSKeyboardControlsDirectionPrevious)
                
                    [self resetFrame];
        
        }else if (textField == self.txtEmail){
        
            [self moveView:self.txtEmail.frame];
        
        }else if (textField == self.txtName){
            
            [self moveView:self.txtName.frame];
        }
}

-(void) keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls{
    
    [keyboardControls.activeField resignFirstResponder];
    [self resetFrame];
}
#pragma mark -
#pragma mark - UITextFieldDelegate

#pragma mark UITextFieldDelegate

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");
    if (isBackSpace == -8) // is backspace
        {
        NSMutableString *str = [NSMutableString stringWithString:textField.text];
        if ( [str length] > 0) {
            [str deleteCharactersInRange:range];
            textField.text = str;
            [self performSelector:@selector(updateTextFieldCursorPosition:) withObject:@[textField, NSStringFromRange(range)] afterDelay:0.001f];
        }
        return NO;
        }
    
    if (textField==self.txtUsername) {
        NSArray *escapeChars = [NSArray arrayWithObjects:@" ", nil];
        
        NSArray *replaceChars = [NSArray arrayWithObjects:@"",nil];
        int len = [escapeChars count];
        NSMutableString *temp = [[textField text] mutableCopy];
        for(int i = 0; i < len; i++) {
            [temp replaceOccurrencesOfString: [escapeChars objectAtIndex:i] withString:[replaceChars objectAtIndex:i] options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
        }
        
        [textField setText:temp];
    }
    
    
    NSCharacterSet *unacceptedInput = nil;
    
    if (textField==self.txtName && isBackSpace!=-8) {
        unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:ALPHA] invertedSet];
        return ([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] <= 1);
    }
    return TRUE;
}

- (void)updateTextFieldCursorPosition:(NSArray *)params
{
    UITextField *tf = (UITextField *)[params objectAtIndex:0];
    NSRange range = NSRangeFromString([params objectAtIndex:1]);
    UITextPosition *newPosition = [tf positionFromPosition:tf.beginningOfDocument offset:range.location];
    UITextRange *newRange = [tf textRangeFromPosition:newPosition toPosition:newPosition];
    tf.selectedTextRange = newRange;
    [tf setNeedsLayout];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self resetFrame];
    
    return TRUE;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField setReturnKeyType:UIReturnKeyDefault];
    
    [self.keyboardControls setActiveField : textField];
    [self keyboardControls : self.keyboardControls
          selectedField    : textField
          inDirection      : BSKeyboardControlsDirectionNext];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 740);
}

- (IBAction)btnUseFacebookInfoPressed:(UIButton *)sender {
    MBProgressHUD *hud = nil;
    if (!self.fbManager){
          hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    self.fbManager = [FacebookManager sharedFacebookManager];
    NSArray *permissions = [[NSArray alloc] initWithObjects:EMAIL, nil];
    [self.fbManager permissions:permissions];
    
    [self.fbManager openSessionWithCompletionHandler:^(NSError *error, SessionState state) {
        
        if (!error && state == OPEN ) {
            [self.fbManager populateUserDetailsWithCompletionHandler:^(FBUser *user, NSError *error) {
               
                self.txtName.text = user.name;
                self.txtEmail.text = user.email;
                [hud hide:YES];
            }];
        }
        
    }];
    
}
@end
