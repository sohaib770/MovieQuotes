//
//  ForgotPasswordFetcher.h
//  GiggClone
//
//  Created by Sohaib Muhammad on 20/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import "AbstractFetcher.h"

typedef void (^ForgotPasswordSuccess)(NSString *status);
typedef void (^ForgotPasswordError)(NSError *error);

@interface ForgotPasswordFetcher : AbstractFetcher

-(void) forgotPasswordWith:(NSDictionary*)postParams
         completionBlock:(ForgotPasswordSuccess)completed
              errorBlock:(ForgotPasswordError)errored;
@end
