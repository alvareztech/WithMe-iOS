//
//  MovieViewController.h
//  WithMe
//
//  Created by Daniel Alvarez on 16/11/15.
//  Copyright © 2015 Daniel Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Movie.h"
#import "WS.h"
#import "UIImageView+WebCache.h"
#import "UINavigationBar+Awesome.h"

@interface MovieViewController : UIViewController

@property (nonatomic, strong) Movie *movie;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@end
