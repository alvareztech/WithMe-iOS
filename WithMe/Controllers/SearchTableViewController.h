//
//  SearchTableViewController.h
//  WithMe
//
//  Created by Daniel Alvarez on 10/11/15.
//  Copyright © 2015 Daniel Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "WS.h"
#import "UIImageView+WebCache.h"

@interface SearchTableViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end
