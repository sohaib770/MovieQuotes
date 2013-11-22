
//
    //  URLBuilder.h
    //  GiggClone
    //
    //  Created by Sohaib Muhammad on 19/11/2013.
    //  Copyright (c) 2013 iDevNerds. All rights reserved.
    //
#import <Foundation/Foundation.h>

@interface URLBuilder : NSObject

+ (NSURL*)urlForMethod:(NSString*)method withParameters:(NSDictionary*)params;

@end
