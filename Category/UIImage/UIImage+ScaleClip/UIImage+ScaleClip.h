//
//  UIImage+ScaleClip.h
//  CagetorysExample
//
//  Created by yangjunhai on 14-7-12.
//  Copyright (c) 2014年 soooner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScaleClip)

- (UIImage *)rescaleImageToSize:(CGSize)size;                   //图片大小重定义

- (UIImage *)clipImageToSize:(CGSize)size scale:(BOOL)scale;    //图片裁剪并且缩放

- (UIImage *)cornerImageToRadius:(int)radius margin:(int)margin marginColor:(UIColor *)clolor; //图片圆角、边框

- (UIImage *)scaleImageToSize:(CGSize)size;

@end
