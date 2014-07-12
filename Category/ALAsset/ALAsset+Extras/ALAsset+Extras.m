//
//  ALAsset+Extras.m
//  ohmybaby
//
//  Created by yangjunhai on 12/25/13.
//  Copyright (c) 2013 soooner. All rights reserved.
//

#import "ALAsset+Extras.h"
#import "UIImageExtras.h"
#import "UIImage+ScaleClip.h"

@implementation ALAsset (Extras)

-(UIImage *)cropFullResolutionImage{
    ALAssetRepresentation *assetRepresentation = [self defaultRepresentation];
    
    UIImage *fullResolutionImage = [[UIImage alloc] initWithCGImage:assetRepresentation.fullResolutionImage];
    
    return [fullResolutionImage cropImage];
}

-(UIImage *)cropFullScreenImage{
    ALAssetRepresentation *assetRepresentation = [self defaultRepresentation];
    
    UIImage *fullScreenImage = [[UIImage alloc] initWithCGImage:assetRepresentation.fullScreenImage];
    
   return [fullScreenImage cropImage];
}

-(BOOL)cropFullResolutionImageSaveJPEG:(NSString *)path{
    ALAssetRepresentation *assetRepresentation = [self defaultRepresentation];
    
    UIImage *fullResolutionImage = [[UIImage alloc] initWithCGImage:assetRepresentation.fullResolutionImage];
    
    UIImage *thumbnailImage = [fullResolutionImage cropImage];
    
    return [thumbnailImage saveToJPEG:path];
}
-(BOOL)cropFullScreenImageSaveJPEG:(NSString *)path{
    ALAssetRepresentation *assetRepresentation = [self defaultRepresentation];
    
    UIImage *fullScreenImage = [[UIImage alloc] initWithCGImage:assetRepresentation.fullScreenImage];
    
    UIImage *thumbnailImage = [fullScreenImage cropImage];
    
    return [thumbnailImage saveToJPEG:path];
}
-(BOOL)cropFullScreenImageSaveJPEG:(NSString *)path size:(CGSize)size{
    ALAssetRepresentation *assetRepresentation = [self defaultRepresentation];
    
    UIImage *fullScreenImage = [[UIImage alloc] initWithCGImage:assetRepresentation.fullScreenImage];
    
    UIImage *thumbnailImage = [[fullScreenImage cropImage] rescaleImageToSize:size];
    
    return [thumbnailImage saveToJPEG:path];
}


+(void)loadAssetWithURL:(NSURL *)url resultBlock:(PathForURLResultBlock)resultBlock{
    NSString *temporaryDirectory = NSTemporaryDirectory();
    NSFileManager *manager =[NSFileManager defaultManager];
    [manager createDirectoryAtPath:[temporaryDirectory stringByAppendingPathComponent:@"asset"] withIntermediateDirectories:YES attributes:nil error:NULL];
    NSString *filePath =[NSString stringWithFormat:@"%@/%lld.jpg",[temporaryDirectory stringByAppendingPathComponent:@"asset"],(long long)(CFAbsoluteTimeGetCurrent() *1000000)];
    
    ALAssetsLibrary *library =[[ALAssetsLibrary alloc] init];
    
    [library assetForURL:url
             resultBlock:^(ALAsset *asset) {
                 @try {
                     
                     ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
                     
                     if(assetRepresentation){
                     
                         UIImage *fullScreenImage = [[UIImage alloc] initWithCGImage:assetRepresentation.fullScreenImage];
                     
                         [UIImageJPEGRepresentation(fullScreenImage,0.8) writeToFile:filePath atomically:YES];
                         NSDate  *date = [asset valueForProperty:ALAssetPropertyDate];
                         
                         NSLog(@"ALAssetPropertyDate:%@",date);
                         resultBlock(filePath,date);
                     }else{
                         resultBlock(nil,nil);
                     }
                     
                 }
                 @catch (NSException *exception) {
                     NSLog(@"operation was not successfull!");
                     resultBlock(nil,nil);
                 }
             }
            failureBlock:^(NSError *error){
                NSLog(@"operation was not successfull!");
                resultBlock(nil,nil);
            }
     ];
}
+(void)loadAssetWithURL:(NSString *)asseturl path:(NSString *)path resultBlock:(AssetLoadBlock)resultBlock{
    
    ALAssetsLibrary *library =[[ALAssetsLibrary alloc] init];
    
    [library assetForURL:[NSURL URLWithString:asseturl]
             resultBlock:^(ALAsset *asset) {
                 @try {
                     
                     ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
                     
                     if(assetRepresentation){
                         
                         UIImage *fullScreenImage = [[UIImage alloc] initWithCGImage:assetRepresentation.fullScreenImage];
                         
                         [UIImageJPEGRepresentation(fullScreenImage,0.8) writeToFile:path atomically:YES];
                     }
                     
                         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                             @try {
                                    resultBlock(path); 
                             }
                             @catch (NSException *exception) {
                                 
                             }
                             
                         }];
                 }
                 @catch (NSException *exception) {
                     NSLog(@"operation was not successfull!");
                     resultBlock(path);
                 }
             }
            failureBlock:^(NSError *error){
                NSLog(@"operation was not successfull!");
                resultBlock(path);
            }
     ];
}

+(void)loadAssetThumbWithURL:(NSString *)asseturl path:(NSString *)path resultBlock:(AssetLoadBlock)resultBlock{
    
    ALAssetsLibrary *library =[[ALAssetsLibrary alloc] init];
    
    
    
    [library assetForURL:[NSURL URLWithString:asseturl]
             resultBlock:^(ALAsset *asset) {
                 @try {
                     
                     ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
                     
                     if(assetRepresentation){
                         
                         UIImage *fullScreenImage = [[UIImage alloc] initWithCGImage:assetRepresentation.fullScreenImage];
                         
                         UIImage *thumbImage = [fullScreenImage clipImageToSize:CGSizeMake(300, 300) scale:YES];
                         
                         [UIImageJPEGRepresentation(thumbImage,0.8) writeToFile:path atomically:YES];
                     }
                     
                     resultBlock(path);
                 }
                 @catch (NSException *exception) {
                     NSLog(@"operation was not successfull!");
                     resultBlock(path);
                 }
             }
            failureBlock:^(NSError *error){
                NSLog(@"operation was not successfull!");
                resultBlock(path);
            }
     ];
}

@end
