//
//  UIColor+WithMe.m
//  WithMe
//
//  Created by Daniel Alvarez on 14/11/15.
//  Copyright © 2015 Daniel Alvarez. All rights reserved.
//

#import "UIColor+WithMe.h"

@implementation UIColor (WithMe)

// 96,125,139

+ (UIColor *) primaryColor {
    return [UIColor colorWithRed:96/255.0 green:125/255.0 blue:139/255.0 alpha:1]; // Blue Grey
}

+ (UIColor *) secondaryColor {
    return [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.5]; // gray
}

@end
