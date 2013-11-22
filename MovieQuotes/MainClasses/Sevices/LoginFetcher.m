//
//  LoginFetcher.m
//  GiggClone
//
//  Created by Sohaib Muhammad on 19/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import "LoginFetcher.h"
#import "URLBuilder.h"
#import "Constants.h"
#import "SBJson.h"
@implementation LoginFetcher

-(void) loginUserWith:(NSDictionary*)postParams
      completionBlock:(LoginUserSuccess)completed
           errorBlock:(LoginUserError)errored{
    
    NSURL *url = [URLBuilder urlForMethod:kAccountAuthenticateURL withParameters:nil];
	
    SBJsonWriter *json = [[SBJsonWriter alloc] init];
    
    NSString *jsonStr = [json stringWithObject:postParams];
    
    NSLog(@"%@",url);

    
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
