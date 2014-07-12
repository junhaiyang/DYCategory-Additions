//
//  UIView+Control.h
//  mvoice
//
//  Created by yangjunhai on 14-7-12.
//  Copyright (c) 2014年 soooner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Click)
  
@property (nonatomic,assign) NSInteger controlKey;

@property (nonatomic,strong) NSString *controlKeyStr;

- (void)addTarget:(id)target action:(SEL)action;

- (void)removeTarget:(id)target action:(SEL)action;


@end
