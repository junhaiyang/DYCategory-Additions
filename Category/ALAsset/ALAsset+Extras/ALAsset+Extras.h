//
//  ALAsset+Extras.h
//  ohmybaby
//
//  Created by yangjunhai on 12/25/13.
//  Copyright (c) 2013 soooner. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>


typedef void (^PathForURLResultBlock)(NSString *filePath,NSDate *date);
typedef void (^AssetLoadBlock)(NSString *path);

@interface ALAsset (Extras)

-(UIImage *)cropFullResolutionImage;

-(UIImage *)cropFullScreenImage;

-(BOOL)cropFullResolutionImageSaveJPEG:(NSString *)path;

-(BOOL)cropFullScreenImageSaveJPEG:(NSString *)path;

-(BOOL)cropFullScreenImageSaveJPEG:(NSString *)path size:(CGSize)size;

+(void)loadAssetWithURL:(NSURL *)url resultBlock:(PathForURLResultBlock)resultBlock;

+(void)loadAssetWithURL:(NSString *)asseturl path:(NSString *)path resultBlock:(AssetLoadBlock)resultBlock;

+(void)loadAssetThumbWithURL:(NSString *)asseturl path:(NSString *)path resultBlock:(AssetLoadBlock)resultBlock;

@end
