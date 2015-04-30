//
//  UIView+Control.h
//  mvoice
//
//  Created by yangjunhai on 14-7-12.
//  Copyright (c) 2014年 soooner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Click)
  
@property (nonatomic,assign) NSInteger additionControlKey;

@property (nonatomic,strong) NSString *additionControlKeyStr;

- (void)addExtendClickTarget:(id)target action:(SEL)action;

- (void)removeExtendClickTarget:(id)target action:(SEL)action;


@end
