//
//  MovieViewController.m
//  WithMe
//
//  Created by Daniel Alvarez on 16/11/15.
//  Copyright © 2015 Daniel Alvarez. All rights reserved.
//

#import "MovieViewController.h"

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.movie.title;
    
    [self getMovieDetail];
}

- (void) getMovieDetail {
    NSLog(@"getMovieDetail");

    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[WS getMovieURL:self.movie.ide] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", json);
            
            [self parseJSON:json];
            NSLog(@"end todo");
        } else {
            NSLog(@"Error %@", error);
        }
        
    }];
    
    [dataTask resume];
}



- (void) parseJSON:(NSDictionary *) json {
    NSLog(@"parseJSON");
    
    NSString *backdropPath = [json objectForKey:@"backdrop_path"];
    
    [self.bannerImageView sd_setImageWithURL:[WS getImageURL:backdropPath]
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
    });
}



@end
