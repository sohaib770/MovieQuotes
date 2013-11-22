//
//  UserDetails.h
//  GiggClone
//
//  Created by Sohaib Muhammad on 19/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserDetails : NSObject

@property (nonatomic, strong)               NSString *customerID;
@property (nonatomic, readonly)             NSString *username;
@property (weak, nonatomic, readonly)       NSURL *thumbnailURL;
@property (weak, nonatomic)                 NSURL *coverURL;
@property (nonatomic, readonly)             NSURL *imageURL;
@property (weak, nonatomic, readonly)   UIImage *thumbnail;
@property (nonatomic, readonly) NSString *verifyID;

@property (weak, nonatomic, readonly) NSString *name;
@property (weak, nonatomic, readonly) NSString *usernameFormatted;
@property (nonatomic, readonly) NSString *firstName;
@property (nonatomic, readonly) NSString *lastName;
@property (nonatomic, readonly) NSString *email;

@property (nonatomic, readonly) NSString *favoriteArtist;
@property (nonatomic, readonly) NSString *favoriteConcert;
@property (nonatomic, readonly) NSString *firstAlbum;
@property (nonatomic, readonly) NSString *about;

@property (nonatomic, readonly) NSNumber *postCount;
@property (nonatomic, readonly) NSNumber *followerCount;
@property (nonatomic, readonly) NSNumber *followingCount;
@property (nonatomic, readonly) NSNumber *fbuid;
@property (nonatomic, readonly) NSNumber *twitterId;

@property BOOL isPrivate;
@property BOOL isVerified;

- (void)populateInfo:(NSDictionary*) data;
@end
