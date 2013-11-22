//
//  NSDictionary+TypeCast.m
//  TopBlip
//
//  Created by Avantar Developer on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+TypeCast.h"

@implementation NSDictionary (TypeCast)

- (id)objectForKey:(id)aKey ofType:(Class)type {
    id result = [self objectForKey:aKey];
    
    if ([result isKindOfClass:type]) {
        return result;
        
    } else {
        if (type == [NSString class]) {
            if ([result isKindOfClass:[NSNumber class]]) {
                return [result description];
            }
        } else if (type == [NSNumber class]) {
            if ([result isKindOfClass:[NSString class]]) {
                return [NSNumber numberWithDouble:[result doubleValue]];
            }
        }
        
        return nil;
    }
}

- (NSURL*)urlForKey:(id)aKey {
    id result = [self objectForKey:aKey];
    
    if ([result isKindOfClass:[NSURL class]]) {
        return result;
        
    } else if ([result isKindOfClass:[NSString class]] && [result length]) {
        return [NSURL URLWithString:result];
        
    } else {
        return nil;
    }
}

@end
