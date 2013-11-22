//
//  UserService.m
//  GiggClone
//
//  Created by Sohaib Muhammad on 19/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import "UserService.h"
#import "Constants.h"
#import "LoginFetcher.h"
#import "RegistrationFetcher.h"
#import "ForgotPasswordFetcher.h"

@class UserDetails;
@implementation UserService

+(void)loginUserWithUsername:(NSString *)username
                  andPassword:(NSString *)password
              completionBlock:(UserServiceLoginSuccess)completed
                   errorBlock:(UserServiceLoginError)errored{
    NSDictionary *postParams = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                    username,
                                                                    password,
                                                                    nil]
                                                           forKeys:[NSArray arrayWithObjects:
                                                                    kEmail,
                                                                    kPassword,
                                                                    nil]];
    
    UserServiceLoginSuccess SuccessBlock = ^(UserDetails *userDetails ){
        completed(userDetails);
	};
    
	
	UserServiceLoginError ErrorBlock = ^(NSError *error){
        errored(error);
	};
    LoginFetcher *loginFetcher = [[LoginFetcher alloc] init];
    
    [loginFetcher loginUserWith:postParams completionBlock:SuccessBlock errorBlock:ErrorBlock];
    
}
+(void)registerUserWithUsername:(NSString *)username
                           name:(NSString *)name
                   emailAddress:(NSString *)email
                 profilePicutre:(UIImage *)profilePic
                       password:(NSString *)password
                completionBlock:(UserServiceRegistrationSuccess)completed
                     errorBlock:(UserServiceRegsitrationError)errored{
    
    NSString *fName = nil;
    NSString *lName = nil;
    NSArray *nameArray = [name componentsSeparatedByString:@" "];
    fName = [nameArray objectAtIndex:0];
       if (nameArray.count>1) {
        lName = [nameArray objectAtIndex:1];
    }else
        lName = @"";
    
    if (!profilePic) {
        profilePic = nil;
    }
    
    
    
    NSDictionary *postParams = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                    username,
                                                                    password,
                                                                    fName,
                                                                    lName,
                                                                    email,
                                                                    [NSNumber numberWithInt:0],
                                                                    nil]
                                                           forKeys:[NSArray arrayWithObjects:
                                                                    kUsername,
                                                                    kPassword,
                                                                    kFirstName,
                                                                    kLastName,
                                                                    kEmail,
                                                                    kVerified,
                                                                    nil]];
    
  
    RegistrationFetcher *registrationFetcher = [[RegistrationFetcher alloc] init];
    
    [registrationFetcher registerUserWith:postParams completionBlock:^(NSError *error) {
        completed(error);
        
    } errorBlock:^(NSError *error) {
        errored(error);
    }];
}
+(void)forgotPasswordWithEmail:(NSString *)email
               completionBlock:(UserServiceRegistrationSuccess)completed
                    errorBlock:(UserServiceRegsitrationError)errored{
    
    NSDictionary *postParams = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                    email,
                                                                    nil]
                                                           forKeys:[NSArray arrayWithObjects:
                                                                    kEmail,
                                                                    nil]];
    
    
    ForgotPasswordFetcher *forgotPassword = [[ForgotPasswordFetcher alloc] init];
    
    [forgotPassword forgotPasswordWith:postParams completionBlock:^(NSString *status) {
        
    } errorBlock:^(NSError *error) {
        
    }];
    

    
}

@end
