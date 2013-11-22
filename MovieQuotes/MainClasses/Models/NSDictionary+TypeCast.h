//
//  NSDictionary+TypeCast.h
//  TopBlip
//
//  Created by Avantar Developer on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TypeCast)

/// retrieves the objects from the dictionary, if the object
/// is not of type 'type', the nil is returned
- (id)objectForKey:(id)aKey ofType:(Class)type;

- (NSURL*)urlForKey:(id)aKey;

@end
