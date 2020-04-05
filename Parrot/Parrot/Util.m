//
//  Util.m
//  Parrot
//
//  Created by Elena Gracheva on 26.07.15.
//  Copyright (c) 2015 Parrot. All rights reserved.
//

#import "Util.h"

@implementation Util


+(UIImage*)imageNamed:(NSString*)imageName{
    
    UIImage *image;
    NSString *path = imageName;
    if ([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location != NSNotFound) {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00) {
            
            // IPAD RETINA DISPLAY
            path = [imageName stringByAppendingString:@"@2x"];
        }
    } else {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 3.00) {
            // IPHONE SCALE 3x
            path = [imageName stringByAppendingString:@"@3x"];
        } else if ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 568) {
            path = [imageName stringByAppendingString:@"-640x1136"];
        } else if ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 480) {
            path = [imageName stringByAppendingString:@"-640x960@2x"];
        }
    }
    
    image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"jpg"]];
    return image;
}

@end
