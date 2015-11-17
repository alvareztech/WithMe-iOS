//
//  WS.h
//  WithMe
//
//  Created by Daniel Alvarez on 12/11/15.
//  Copyright © 2015 Daniel Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WS : NSObject

#define API_KEY_VALUE @"589e10387e0ca4ece633f5836fb0383f"
#define LANGUAGE_VALUE @"es"

#define PROTOCOL @"http"
#define HOST @"api.themoviedb.org"
#define PORT @"80"

#define URI_SEARCH @"3/search/movie?query="
#define URI_IMAGE @"image.tmdb.org/t/p/w500"
// https://api.themoviedb.org/3/movie/168259?api_key=589e10387e0ca4ece633f5836fb0383f&language=es

#define URI_MOVIE @"api.themoviedb.org/3/movie/"


+ (NSString *) apiKey;
+ (NSString *) language;
+ (NSURL *) getSearchURL: (NSString *) text;

+ (NSURL *) getMovieURL: (NSString *) code;

+ (NSURL *) getImageURL: (NSString *) name;

@end
