//
//  WS.h
//  WithMe
//
//  Created by Daniel Alvarez on 12/11/15.
//  Copyright © 2015 Daniel Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WS : NSObject

#define API_KEY @"589e10387e0ca4ece633f5836fb0383f"

#define PROTOCOL @"http"
#define HOST @"api.themoviedb.org"
#define PORT @"80"

#define URI_SEARCH @"3/search/movie?query="
#define URI_IMAGE @"image.tmdb.org/t/p/w500"

+ (NSString *) getApiKeyURL;
+ (NSString *) getSearchURL: (NSString *) text;

+ (NSURL *) getImageURL: (NSString *) name;

@end
