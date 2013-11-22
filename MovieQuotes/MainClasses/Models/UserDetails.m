//
//  UserDetails.m
//  GiggClone
//
//  Created by Sohaib Muhammad on 19/11/2013.
//  Copyright (c) 2013 iDevNerds. All rights reserved.
//
#import "Constants.h"
#import "UserDetails.h"
#import "NSDictionary+TypeCast.h"
#import "NSData+NSDataBase64Encoding.h"
@interface UserDetails (){

     NSDate *_lastUpdate;
}


@end

@implementation UserDetails
    //setter methods
@synthesize customerID = _customerID;
@synthesize username = _username;
@synthesize imageURL = _imageURL;
@dynamic thumbnailURL;
@dynamic name;
@dynamic usernameFormatted;
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;

@synthesize favoriteArtist = _favoriteArtist;
@synthesize favoriteConcert = _favoriteConcert;
@synthesize firstAlbum = _firstAlbum;
@synthesize about=_about;
@synthesize thumbnail=_thumbnail;


@synthesize postCount = _postCount;
@synthesize followerCount = _followerCount;
@synthesize followingCount = _followingCount;
@synthesize email;
@synthesize isPrivate = _isPrivate;

- (void)setFirstName:(NSString *)firstName {
    if (firstName != _firstName) {
        _firstName = firstName;
    }
}

- (void)setLastName:(NSString *)lastName {
    if (lastName != _lastName) {
        _lastName = lastName;
    }
}

- (void)setFavoriteArtist:(NSString *)favoriteArtist {
    if (favoriteArtist != _favoriteArtist) {
        _favoriteArtist = favoriteArtist;
    }
}

- (void)setFavoriteConcert:(NSString *)favoriteConcert {
    if (favoriteConcert != _favoriteConcert) {
        _favoriteConcert = favoriteConcert;
    }
}

- (void)setFirstAlbum:(NSString *)firstAlbum {
    if (firstAlbum != _firstAlbum) {
        _firstAlbum = firstAlbum;
    }
}

- (void)setAbout:(NSString *)about {
    if (about != _about) {
        _about = about;
    }
}

- (void)setLastUpdate:(NSDate*) date {
    if (date != _lastUpdate) {
        _lastUpdate = date;
    }
}

- (void)setPostCount:(NSNumber *)postCount {
    if (postCount != _postCount) {
        _postCount = postCount;
    }
}

- (void)setFollowerCount:(NSNumber *)followerCount {
    if (followerCount != _followerCount) {
        _followerCount = followerCount;
    }
}

- (void)setFollowingCount:(NSNumber *)followingCount {
    if (followingCount != _followingCount) {
        _followingCount = followingCount;
    }
}

- (void)setFbuid:(NSNumber *)fbuid {
    if (fbuid != _fbuid) {
        _fbuid = fbuid;
    }
}

- (void)setImageURL:(NSURL *)imageURL {
    if (imageURL != _imageURL) {
        _imageURL = imageURL;
    }
}

- (void)setTwitterId:(NSNumber *)twitterId {
    if (twitterId != _twitterId) {
        _twitterId = twitterId;
    }
}


//- (BOOL)needsUpdate {
//    return [self fanStatusFromActiveUser] == UserFanStatusUnkown ||
//    _lastUpdate == nil || -[_lastUpdate timeIntervalSinceNow] > UPDATE_WAIT_INTERVAL;
//}

- (void)populateInfo:(NSDictionary*) data{
    
    
    if ([data objectForKey:kFirstName ofType:[NSString class]]!=nil && ![[data objectForKey:kFirstName ofType:[NSString class]]isEqual:@""]) {
        NSString *fname = [data objectForKey:kFirstName];
        
        if ([fname isKindOfClass:[NSString class]]) {
            [self setFirstName:fname];
        }
    }
    
    if ([data objectForKey:kLastName ofType:[NSString class]]!=nil && ![[data objectForKey:kLastName ofType:[NSString class]]isEqual:@""]) {
        NSString *lname = [data objectForKey:kLastName];
        
        if ([lname isKindOfClass:[NSString class]])
            [self setLastName:lname];
    }
    
    NSString *custid = [[data objectForKey:kCustId] description];
    
    if (custid) {
        _customerID = custid;
    }
    
    NSString *verifyNo = [[data objectForKey:kVerified] description];
    
    if (verifyNo) {
        _verifyID = verifyNo;
    }
    if ([data objectForKey:kEmail ofType:[NSString class]]!=nil && ![[data objectForKey:kEmail ofType:[NSString class]]isEqual:@""]) {
        NSString *emailStr = [[data objectForKey:kEmail] description];
        
        if (emailStr) {
            email = emailStr;
        }
    }
    
    if ([data objectForKey:kFavArtist ofType:[NSString class]]!=nil && ![[data objectForKey:kFavArtist ofType:[NSString class]]isEqual:@""]) {
        NSString *favoriteArtist = [data objectForKey:kFavArtist];
        
        if ([favoriteArtist isKindOfClass:[NSString class]]) {
            [self setFavoriteArtist:favoriteArtist];
        }
    }
    
    if (data[@"cover_url"]) {
        self.coverURL = [data urlForKey:@"cover_url"];
    }
    
    if (data[@"private_profile"]) {
        NSString *status = data[@"private_profile"];
        if ([status isEqualToString:@"1"]) {
            self.isPrivate = YES;
        }
        else
            self.isPrivate = NO;
    }
    
    if (data[@"celebrity"]) {
        NSString *status = data[@"celebrity"];
        if ([status isEqualToString:@"1"]) {
            self.isVerified = YES;
        }
        else
            self.isVerified = NO;
    }
    
    if ([data objectForKey:@"fbuid"]) {
        [self setFbuid:[data objectForKey:@"fbuid" ofType:[NSNumber class]]];
    }
    if ([data objectForKey:@"twitter_id"]) {
        [self setTwitterId:[data objectForKey:@"twitter_id" ofType:[NSNumber class]]];
    }
    if ([data objectForKey:kBestConcert ofType:[NSString class]]!=nil && ![[data objectForKey:kBestConcert ofType:[NSString class]]isEqual:@""]) {
        NSString *favoriteConcert = [data objectForKey:kBestConcert];
        
        if ([favoriteConcert isKindOfClass:[NSString class]]) {
            [self setFavoriteConcert:favoriteConcert];
        }
    }
    
    if ([data objectForKey:kFirstAlbum ofType:[NSString class]]!=nil && ![[data objectForKey:kFirstAlbum ofType:[NSString class]]isEqual:@""]) {
        NSString *firstAlbum = [data objectForKey:kFirstAlbum];
        
        if ([firstAlbum isKindOfClass:[NSString class]]) {
            [self setFirstAlbum:firstAlbum];
        }
    }
    
    if ([data objectForKey:kAbout ofType:[NSString class]]!=nil && ![[data objectForKey:kAbout ofType:[NSString class]]isEqual:@""]) {
        NSString *about = [data objectForKey:kAbout];
        
        if ([about isKindOfClass:[NSString class]]) {
            [self setAbout:about];
        }
    }
    
    if ([data objectForKey:kPostCount]) {
        [self setPostCount:[data objectForKey:kPostCount ofType:[NSNumber class]]];
    }
    if ([data objectForKey:kFollowerCount]) {
        [self setFollowerCount:[data objectForKey:kFollowerCount ofType:[NSNumber class]]];
    }
    if ([data objectForKey:@"following_count"]) {
        [self setFollowingCount:[data objectForKey:@"following_count" ofType:[NSNumber class]]];
    }
    NSURL *imageURL;
    
    if ([data urlForKey:kAvatarURL]) {
        imageURL = [data urlForKey:kAvatarURL];
    } else {
        imageURL = [data urlForKey:kAvatar];
    }
    
    if (imageURL) {
        [self setImageURL:imageURL];
    }
    
    NSString *thumbnailString = [data objectForKey:@"image_base64" ofType:[NSString class]];
    
    if (thumbnailString) {
        UIImage *newImage = nil;
        
        NSData *data = [NSData dataWithBase64String:thumbnailString];
        
        if (data) {
            newImage = [[UIImage alloc] initWithData:data];
        }
        
        if (newImage) {
            _thumbnail = newImage;
        }
    }

}

@end
