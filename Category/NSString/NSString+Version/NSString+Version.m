//
//  NSString+Version.m
//  iCarouselNoNibDemo
//
//
//
//

#import "NSString+Version.h"

@implementation NSString (Version)
 
-(BOOL) isOlderVersionThan:(NSString*)otherVersion
{
    return ([self compare:otherVersion options:NSNumericSearch] == NSOrderedAscending);
}
-(BOOL) isNewerVersionThan:(NSString*)otherVersion
{
    return ([self compare:otherVersion options:NSNumericSearch] == NSOrderedDescending);
}
@end 
