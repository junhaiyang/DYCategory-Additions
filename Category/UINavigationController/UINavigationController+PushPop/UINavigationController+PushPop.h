//
//  UINavigationController+Custom.h 
//

#import <UIKit/UIKit.h>

@interface UINavigationController(PushPop)

- (NSArray *)popToViewControllerClass:(Class)aClass animated:(BOOL)animated;

  
- (UINavigationController *)presentNavigationViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion;


@end


@interface UINavigationBar (BackgroundTitle)

-(void)setBackgroundImage:(UIImage *)image;
-(void)setBackgroundColor1:(UIColor *)color;

-(void)setTitleColor:(UIColor *)color;

-(void)setTitleColor:(UIColor *)color font:(UIFont *)font titleShadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset;

@end
