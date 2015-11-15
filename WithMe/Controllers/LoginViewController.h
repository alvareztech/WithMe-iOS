//
//  LoginViewController.h
//  WithMe
//
//  Created by Daniel Alvarez on 14/11/15.
//  Copyright © 2015 Daniel Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DigitsKit/DigitsKit.h>
#import <Parse/Parse.h>
#import "UIColor+WithMe.h"
#import "PFUser+Digits.h"

@interface LoginViewController : UIViewController

- (IBAction)signIn:(UIButton *)sender;

@end
