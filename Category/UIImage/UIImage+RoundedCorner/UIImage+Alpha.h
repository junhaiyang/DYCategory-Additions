//
//  UIImage+Alpha.h
//  MKMessageInputView
//
//  Created by Robin.Chao on 14-7-11.
//  Copyright (c) 2014年 mRocker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Alpha)

- (BOOL)hasAlpha;

- (UIImage *)imageWithAlpha;

- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;

@end
