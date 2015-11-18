//
//  MovieViewController.m
//  WithMe
//
//  Created by Daniel Alvarez on 16/11/15.
//  Copyright © 2015 Daniel Alvarez. All rights reserved.
//

#import "MovieViewController.h"

#define NAVBAR_CHANGE_POINT 50

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    self.titleLabel.text = self.movie.title;
    
    [self getMovieDetail];
}

- (void)viewWillAppear:(BOOL)animated {
    [self scrollViewDidScroll:self.infoTableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
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
