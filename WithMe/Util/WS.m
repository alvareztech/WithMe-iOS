//
//  WS.m
//  WithMe
//
//  Created by Daniel Alvarez on 12/11/15.
//  Copyright © 2015 Daniel Alvarez. All rights reserved.
//

#import "WS.h"

@implementation WS

+ (NSString *) apiKey {
    return [NSString stringWithFormat:@"api_key=%@", API_KEY_VALUE];
}

+ (NSString *) language {
    return [NSString stringWithFormat:@"language=%@", LANGUAGE_VALUE];
}

+ (NSURL *) getSearchURL: (NSString *) text {
    // http://api.themoviedb.org/3/search/movie?query=%@&api_key=589e10387e0ca4ece633f5836fb0383f
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@%@&%@&%@", PROTOCOL, HOST, PORT, URI_SEARCH, text, [WS apiKey], [WS language]];
    NSLog(@"getSearchURL %@", urlString);
    return [NSURL URLWithString:urlString];
}

+ (NSURL *) getImageURL: (NSString *) name {
    NSString *urlString = [NSString stringWithFormat:@"%@://%@%@", PROTOCOL, URI_IMAGE, name];
    NSLog(@"getImageURL %@", urlString);
    return [NSURL URLWithString:urlString];
}


+ (NSURL *) getMovieURL: (NSString *) code {
    NSString *urlString = [NSString stringWithFormat:@"%@://%@%@?%@&%@", PROTOCOL, URI_MOVIE, code, [WS apiKey], [WS language]];
    NSLog(@"getMovieURL %@", urlString);
    return [NSURL URLWithString:urlString];
}

@end
