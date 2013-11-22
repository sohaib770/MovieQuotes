//
//  LocationManager.h
//  FacebookIntegration
//
//  Created by Sohaib Muhammad on 12/06/2013.
//  Copyright (c) 2013 coeus. All rights reserved.
//

#define DISTANCE_THRESHOLD      100.0
typedef enum{
    
    LocationUpdateStatusOK,
    LocationUpdateStatusFailure
    
}LocationUpdateStatus;


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationUpdateWithCompletionHandler)(LocationUpdateStatus status, NSError *error);
@interface LocationManager : NSObject

-(BOOL) locationServiceEnable;
-(CLLocationCoordinate2D)currentCoordinate;
-(void)startUpdatingLocaitonWithCompletionHandler:(LocationUpdateWithCompletionHandler)handler;
-(void)stopUpdatingLocation;
-(void)resetLocation;
+(LocationManager *)sharedLocationManager;
@end
