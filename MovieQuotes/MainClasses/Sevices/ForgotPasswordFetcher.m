//
//  ForgotPasswordFetcher.m
//  GiggClone
//
//  Created by Sohaib Muhammad on 20/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import "ForgotPasswordFetcher.h"
#import "Constants.h"
#import "SBJson.h"
#import "URLBuilder.h"

@implementation ForgotPasswordFetcher
-(void) forgotPasswordWith:(NSDictionary*)postParams
         completionBlock:(ForgotPasswordSuccess)completed
              errorBlock:(ForgotPasswordError)errored{
    
    NSURL *url = [URLBuilder urlForMethod:kAccountForgotPasswordURL withParameters:nil];
	
    SBJsonWriter *json = [[SBJsonWriter alloc] init];
    
    NSString *jsonStr = [json stringWithObject:postParams];
    

	[super fetchWithUrl:url
		 withMethodType:METHOD_POST
         withJsonString:jsonStr
		completionBlock:^(NSData *webRawData){
                //parse data and send back
            
                //			LoginUserParser *parser = [LoginUserParser new];
                //            [parser getDetailedUserParsedWith:webRawData
                //                              completionBlock:^(DetailedUser *detailedUser) {
                //                                  completed(detailedUser);
                //                              }
                //                                   errorBlock:^(NSError *error) {
                //                                       errored(error);
                //                                   }];
		}
			 errorBlock:^(NSError *error){
				 errored(error);
			 }];

}
@end
