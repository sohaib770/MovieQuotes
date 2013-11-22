//
//  LocationManager.m
//  FacebookIntegration
//
//  Created by Sohaib Muhammad on 12/06/2013.
//  Copyright (c) 2013 coeus. All rights reserved.
//  

#import "LocationManager.h"



static LocationManager *instance = nil;

@interface LocationManager ()<CLLocationManagerDelegate>

@property CLLocation *location;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (copy) LocationUpdateWithCompletionHandler locaitonUpdateHandler;
@property (assign) BOOL isStartLocationRetrived;


@end

@implementation LocationManager


-(id) init{
    
    NSAssert(instance, @"There can only be one LocationManager instance");
    NSAssert(!instance, @"There can only be one LocationManager instance");
    
    return nil;
}
-(id) initSharedInstance{
    
    self    = [super init];
    if (self) {
        
        [self internalInitializer];
        
    }
    return self;
}

+(LocationManager *)sharedLocationManager{
    
   
    if (!instance ) {
        
        instance = [[LocationManager alloc] initSharedInstance];
    }
    return instance;
}

-(void) internalInitializer{
    
    self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    
    if (!self.location) {
        
        self.location = [[CLLocation alloc] init];
    }
    self.isStartLocationRetrived = NO;

}

-(void)startUpdatingLocaitonWithCompletionHandler:(LocationUpdateWithCompletionHandler)handler{
    
    self.locaitonUpdateHandler = handler;
    [self.locationManager startUpdatingLocation];
}


-(void)stopUpdatingLocation{
    
    [self.locationManager stopUpdatingLocation];
}


-(BOOL) locationServiceEnable{
    BOOL result = NO;
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        result = YES;
    }
    
    return result;
}

-(CLLocationCoordinate2D)currentCoordinate{
    
    return self.location.coordinate;
    
}

-(void)resetLocation{
    
    self.isStartLocationRetrived = NO;
}


#pragma mark
#pragma mark - CLLocationManagerDelegate methods implementation

- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations{
 
  
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    if (!self.isStartLocationRetrived) {
        self.location = newLocation;
        self.isStartLocationRetrived = YES;
        self.locaitonUpdateHandler(LocationUpdateStatusOK,nil);
        
    }

    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    self.locaitonUpdateHandler(LocationUpdateStatusFailure,error);
}



@end
