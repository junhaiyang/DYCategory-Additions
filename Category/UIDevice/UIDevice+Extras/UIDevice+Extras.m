//
//  UIDevice+Extras.m
//  ohmybaby
//
//  Created by yangjunhai on 12/30/13.
//  Copyright (c) 2013 soooner. All rights reserved.
//

#import "UIDevice+Extras.h"

@implementation UIDevice (Extras)

+(BOOL)systemGreaterEqual8{
    return ([[UIDevice currentDevice] systemVersion].floatValue>=8.0f);
}
+(BOOL)systemGreaterEqual7{
    return ([[UIDevice currentDevice] systemVersion].floatValue>=7.0f);
}
+(BOOL)systemGreaterEqual6{
    return ([[UIDevice currentDevice] systemVersion].floatValue>=6.0f);
}
 
 

@end
