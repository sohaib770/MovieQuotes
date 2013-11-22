//
//  AbstractFetcher.m
//  GiggClone
//
//  Created by Sohaib Muhammad on 19/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import "AbstractFetcher.h"
#import <AFNetworking.h>
#import "SBJson.h"
#import "Constants.h"
@implementation AbstractFetcher



- (void)fetchWithUrl:(NSURL *)url withMethodType:(MethodType)methodType withJsonString:(NSString *)jsonStr completionBlock:(AbstractFetcherCompletion)completed errorBlock:(AbstractFetcherError)errored{
	
	
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
    
	if (methodType == METHOD_POST) {
        
       
        
        NSLog(@"%@",url);
        
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
        
        [client setParameterEncoding:AFFormURLParameterEncoding];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        
        request = [client requestWithMethod:@"POST" path:nil  parameters:nil];
        
        [request setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            NSLog(@"Error");
        }];
        [operation start];
        
        
    }
}


- (void)fetchWithUrl:(NSURL *)url withMethodType:(MethodType)methodType withMethodBody:(NSDictionary *)params completionBlock:(AbstractFetcherCompletion)completed errorBlock:(AbstractFetcherError)errored{
	
	
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
    
	if (methodType == METHOD_POST) {
        
        
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
        
        [client setParameterEncoding:AFFormURLParameterEncoding];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        
        request = [client requestWithMethod:@"POST" path:nil  parameters:params];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                   NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

            NSLog(@"Error");
        }];
        [operation start];
        
        
    }
}
@end

