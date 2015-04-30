//
//  UIImage+RoundedCorner.h
//  MKMessageInputView
//
//  Created by Robin.Chao on 14-7-11.
//  Copyright (c) 2014年 mRocker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundedCorner)

- (UIImage *)roundedCornerImage:(NSUInteger)cornerSize
                     borderSize:(NSUInteger)borderSize;


- (UIImage *)createRoundedWithRadius:(CGFloat)radius;

@end
