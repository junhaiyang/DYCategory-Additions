//
//  NSString+Version.h
//  iCarouselNoNibDemo
//
//
//
//

#import <Foundation/Foundation.h>

@interface NSString (Version)
-(BOOL) isOlderVersionThan:(NSString*)otherVersion;
-(BOOL) isNewerVersionThan:(NSString*)otherVersion;

@end
