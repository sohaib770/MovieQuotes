//
//  UserService.h
//  GiggClone
//
//  Created by Sohaib Muhammad on 19/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserDetails;

typedef void (^UserServiceLoginSuccess)(UserDetails *userDetails);
typedef void (^UserServiceLoginError)(NSError *error);

typedef void (^UserServiceRegistrationSuccess)(NSError *error);
typedef void (^UserServiceRegsitrationError)(NSError *error);

typedef void (^UserServiceForgotPasswordSuccess)(NSString *status);
typedef void (^UserServiceForgotPasswordError)(NSError *error);


@interface UserService : NSObject

+(void)loginUserWithUsername:(NSString *)username
                  andPassword:(NSString *)password
                completionBlock:(UserServiceLoginSuccess)completed
                     errorBlock:(UserServiceLoginError)errored;

+(void)registerUserWithUsername:(NSString *)username
                    name:(NSString *)name
                   emailAddress:(NSString *)email
                 profilePicutre:(UIImage *)profilePic
                       password:(NSString *)password
             completionBlock:(UserServiceRegistrationSuccess)completed
                  errorBlock:(UserServiceRegsitrationError)errored;
+(void)forgotPasswordWithEmail:(NSString *)email
                    completionBlock:(UserServiceRegistrationSuccess)completed
                     errorBlock:(UserServiceRegsitrationError)errored;
@end
