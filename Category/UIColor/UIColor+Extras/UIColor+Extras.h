//
//  UIColor+Extras.h
//  ohmybaby
//
//  Created by yangjunhai on 13-11-26.
//  Copyright (c) 2013年 soooner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extras)

- (UIColor *)lighterColor;

- (UIColor *)darkerColor;
 
+(UIColor *)colorFromRGB:(unsigned long)rgbValue;

@end
