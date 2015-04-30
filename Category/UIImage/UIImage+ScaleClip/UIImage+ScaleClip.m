//
//  UIImage+ScaleClip.m
//  CagetorysExample
//
//  Created by yangjunhai on 14-7-12.
//  Copyright (c) 2014年 soooner. All rights reserved.
//

#import "UIImage+ScaleClip.h"

@implementation UIImage (ScaleClip)


- (UIImage *)rescaleImageToSize:(CGSize)size {
	CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
	UIGraphicsBeginImageContextWithOptions(rect.size,NO,[UIScreen mainScreen].scale);
	[self drawInRect:rect];  // scales image to rect
	UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return resImage;
}

-(UIImage *)scaleImageToSize:(CGSize)size{
    
    CGFloat sourceWidth  = self.size.width;
    CGFloat sourceHeight = self.size.height;
    
    CGFloat viewWidth  = size.width;
    CGFloat viewHeight = size.height;
    
    CGFloat outWidth  = viewWidth;
    CGFloat outHeight = viewHeight;
    
    CGFloat widthFactor = sourceWidth / viewWidth;
    CGFloat heightFactor = sourceHeight / viewHeight;
    
    CGFloat scaleFactor = widthFactor>heightFactor?widthFactor:heightFactor;
    outWidth =  sourceWidth / scaleFactor;
    outHeight =  sourceHeight / scaleFactor;
    
    CGRect rect = CGRectMake(0.0, 0.0, outWidth, outHeight);
    
	UIGraphicsBeginImageContextWithOptions(rect.size,NO,[UIScreen mainScreen].scale);
    
	[self drawInRect:rect];
    
	UIImage *_image = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
    
    return _image;
}

- (UIImage *)clipImageToSize:(CGSize)size scale:(BOOL)scale{
    CGFloat sourceWidth  = self.size.width;
    CGFloat sourceHeight = self.size.height;
    
    CGFloat viewWidth  = size.width;
    CGFloat viewHeight = size.height;
    
    CGFloat outWidth  = viewWidth;
    CGFloat outHeight = viewHeight;
    
    CGFloat widthFactor = sourceWidth / viewWidth;
    CGFloat heightFactor = sourceHeight / viewHeight;
    
    CGFloat scaleFactor = widthFactor<heightFactor?widthFactor:heightFactor;
    
    outWidth  =  viewWidth * scaleFactor;
    outHeight =  viewHeight * scaleFactor;
    
    CGRect rect = CGRectMake((sourceWidth -outWidth )/2, (sourceHeight -outHeight )/2, outWidth,outHeight);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();//获取当前quartz 2d绘图环境
    
    CGContextTranslateCTM(currentContext, 0-rect.origin.x,sourceHeight-rect.origin.y);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    CGContextClipToRect( currentContext, rect);//设置当前绘图环境到矩形框
    
    CGRect _rect = CGRectMake(0.0, 0.0f, sourceWidth,sourceHeight);
    
    CGContextDrawImage(currentContext, _rect, self.CGImage);//绘图
    
    UIImage *_clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    
    UIImage *_image;
    
    if(scale){
        CGRect srect = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
        UIGraphicsBeginImageContext(srect.size);
        [_clipImage drawInRect:srect];
        _image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }else{
        _image=_clipImage;
    }
    
    return [_image fixOrientation:self.imageOrientation];
}

-(UIImage *)fixOrientation:(UIImageOrientation)_imageOrientation{
    
    // No-op if the orientation is already correct
    if (_imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (_imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (_imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (_imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [[UIImage alloc] initWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

-(UIImage *)cornerImageToRadius:(int)radius margin:(int)margin marginColor:(UIColor *)clolor{
    
    CGFloat viewWidth  = self.size.width;
    CGFloat viewHeight = self.size.height;
    
    CGRect rect = CGRectMake(0, 0, viewWidth,viewHeight);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rectToDraw = CGRectInset(rect, 0, 0);
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:rectToDraw byRoundingCorners:(UIRectCorner)UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    
    /* Background */
    CGContextSaveGState(ctx);
    {
        CGContextAddPath(ctx, borderPath.CGPath);
        
        CGContextSetFillColorWithColor(ctx, clolor.CGColor);
        
        CGContextDrawPath(ctx, kCGPathFill);
    }
    CGContextRestoreGState(ctx);
    {
        
        CGRect _rect=CGRectMake(rect.origin.x+margin, rect.origin.y+margin, rect.size.width-2*margin, rect.size.height-2*margin);
        CGRect rectToDraw = CGRectInset(_rect, margin, margin);
        
        UIBezierPath *iconPath = [UIBezierPath bezierPathWithRoundedRect:rectToDraw byRoundingCorners:(UIRectCorner)UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
        
        /* Image and Clip */
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, iconPath.CGPath);
            CGContextClip(ctx);
            
            CGContextTranslateCTM(ctx, 0.0, self.size.height);
            CGContextScaleCTM(ctx, 1.0, -1.0);
            
            CGContextDrawImage(ctx, _rect, self.CGImage);
            
        }
        
    }
    
    UIImage *_clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return _clipImage;
}

@end
