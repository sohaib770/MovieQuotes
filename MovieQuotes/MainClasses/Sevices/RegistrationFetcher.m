//
//  RegistrationFetcher.m
//  GiggClone
//
//  Created by Sohaib Muhammad on 20/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//
#import "URLBuilder.h"
#import "Constants.h"
#import "RegistrationFetcher.h"

@implementation RegistrationFetcher
-(void) registerUserWith:(NSDictionary*)postParams
         completionBlock:(RegisterUserSuccess)completed
              errorBlock:(RegisterUserError)errored{
    
    NSURL *url = [URLBuilder urlForMethod:kEmailRegisterURL withParameters:nil];
	
	[super fetchWithUrl:url
		 withMethodType:METHOD_POST
         withMethodBody:postParams
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
