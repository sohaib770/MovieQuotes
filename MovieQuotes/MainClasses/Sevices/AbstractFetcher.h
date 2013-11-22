//
//  AbstractFetcher.h
//  GiggClone
//
//  Created by Sohaib Muhammad on 19/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^AbstractFetcherCompletion)(NSData *rawWebData);
typedef void (^AbstractFetcherError)(NSError *error);

typedef enum {
    METHOD_GET,
    METHOD_POST
} MethodType;


@interface AbstractFetcher : NSObject
- (void)fetchWithUrl:(NSURL *)url withMethodType:(MethodType )methodType withMethodBody:(NSDictionary *)params completionBlock:(AbstractFetcherCompletion)completed errorBlock:(AbstractFetcherError)errored;

- (void)fetchWithUrl:(NSURL *)url withMethodType:(MethodType)methodType withJsonString:(NSString *)jsonStr completionBlock:(AbstractFetcherCompletion)completed errorBlock:(AbstractFetcherError)errored;
@end
