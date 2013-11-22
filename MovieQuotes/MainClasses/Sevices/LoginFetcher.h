//
//  LoginFetcher.h
//  GiggClone
//
//  Created by Sohaib Muhammad on 19/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import "AbstractFetcher.h"

@class UserDetails;

typedef void (^LoginUserSuccess)(UserDetails *userDetails);
typedef void (^LoginUserError)(NSError *error);


@interface LoginFetcher : AbstractFetcher

-(void) loginUserWith:(NSDictionary*)postParams
      completionBlock:(LoginUserSuccess)completed
           errorBlock:(LoginUserError)errored;
@end
