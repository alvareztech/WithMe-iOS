//
//  WS.m
//  WithMe
//
//  Created by Daniel Alvarez on 12/11/15.
//  Copyright © 2015 Daniel Alvarez. All rights reserved.
//

#import "WS.h"

@implementation WS

+ (NSString *) getApiKeyURL {
    return [NSString stringWithFormat:@"&api_key=%@", API_KEY];
}

+ (NSString *) getSearchURL: (NSString *) text {
    // http://api.themoviedb.org/3/search/movie?query=%@&api_key=589e10387e0ca4ece633f5836fb0383f
    return [NSString stringWithFormat:@"%@://%@:%@/%@%@%@", PROTOCOL, HOST, PORT, URI_SEARCH, text, [WS getApiKeyURL]];
}

@end
