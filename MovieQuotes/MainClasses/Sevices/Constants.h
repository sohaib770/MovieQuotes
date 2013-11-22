//
//  Constants.h
//  MovieQuotes
//
//  Created by MacBook Pro on 11/9/13.
//  Copyright (c) 2013 MacBook Pro. All rights reserved.
//

#define IS_IPHONE5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define BASE_URL    @"http://api.gigg.com"
#define kEmail      @"email"
#define kUsername   @"username"
#define kPassword   @"password"
#define kStatus     @"status"
#define kSuccess    @"success"
#define kMessage    @"message"
#define kFirstName  @"fname"
#define kLastName   @"lname"
#define kImageData  @"image_data"
#define kVerified @"verified"
#define kCustId @"custid"
#define kFavArtist @"favorite_artist"
#define kBestConcert @"best_concert"
#define kFirstAlbum @"first_album"
#define kAbout @"about"
#define kPostCount @"post_count"
#define kFollowerCount @"follower_count"

#define kAvatarURL @"avatar_url"
#define kAvatar @"avatar"

extern NSString *kAccountAuthenticateURL;
extern NSString *kEmailRegisterURL;
extern NSString *kAccountForgotPasswordURL;
