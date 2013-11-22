
    //
    //  URLBuilder.m
    //  GiggClone
    //
    //  Created by Sohaib Muhammad on 19/11/2013.
    //  Copyright (c) 2013 iDevNerds. All rights reserved.
    //
#import "URLBuilder.h"
#import "Constants.h"

@implementation URLBuilder



+ (NSURL*)urlForMethod:(NSString*)method withParameters:(NSDictionary*)params{
    
    NSURL* result;
    
    NSMutableString *queryString = [[NSMutableString alloc] init];
    
	if([queryString length]>0)
	{
		queryString =[NSMutableString stringWithFormat:@"%@",[queryString substringToIndex:[queryString length]-1]];
	}

	NSString *url=[NSString stringWithFormat:@"%@%@%@",BASE_URL,method,queryString];
	NSString *encodedURL=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    result = [NSURL URLWithString:encodedURL];
    
        //NSLog(@"%s %@",__PRETTY_FUNCTION__,result);
    return result;         
    
}


@end
