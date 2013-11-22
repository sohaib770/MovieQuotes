//
//  RegistrationFetcher.h
//  GiggClone
//
//  Created by Sohaib Muhammad on 20/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import "AbstractFetcher.h"

typedef void (^RegisterUserSuccess)(NSError *error);
typedef void (^RegisterUserError)(NSError *error);

@interface RegistrationFetcher : AbstractFetcher

-(void) registerUserWith:(NSDictionary*)postParams
      completionBlock:(RegisterUserSuccess)completed
           errorBlock:(RegisterUserError)errored;
@end
