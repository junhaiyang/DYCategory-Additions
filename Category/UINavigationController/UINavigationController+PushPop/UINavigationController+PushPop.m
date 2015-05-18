//
//  UINavigationController+Custom.m 
//

#import "UINavigationController+PushPop.h"
#import <objc/runtime.h>

@implementation UINavigationController(PushPop)

- (NSArray *)popToViewControllerClass:(Class)aClass animated:(BOOL)animated{
    UIViewController *controller;
    for (UIViewController *_controller in self.viewControllers) {
        if([_controller isKindOfClass:aClass]){
            controller =_controller;
        }
    }
    if(controller)
        return [self popToViewController:controller animated:animated];
    else
        [self pushViewController:[[aClass alloc] init] animated:NO];
     
    return nil;
}


- (UINavigationController *)presentNavigationViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion{
    UINavigationController *navigationController =  [[UINavigationController alloc] initWithRootViewController:viewControllerToPresent];
    //TODO copy UINavigationBar config
    
    [self presentViewController:navigationController animated:flag completion:completion];
    
    return navigationController;
}

@end
 
@implementation UINavigationBar (BackgroundTitle)

-(void)setBackgroundImage:(UIImage *)image{
        
    if([UIDevice currentDevice].systemVersion.floatValue<7.0f){
        self.layer.masksToBounds = true;
    }
     
    self.translucent = NO;
    
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarPosition:barMetrics:)]) {
        [self setBackgroundImage:image forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    }else{
        if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
            [self setBackgroundImage:image
                       forBarMetrics:UIBarMetricsDefault];
        }
    }
}
-(void)setBackgroundColor1:(UIColor *)color
{
    if([UIDevice currentDevice].systemVersion.floatValue<7.0f){
        self.layer.masksToBounds = true;
    }
    
    self.translucent = NO;
    
    if ([self respondsToSelector:@selector(barTintColor)])
        self.barTintColor = color;
    else self.tintColor = color;
}

-(void)setTitleColor:(UIColor *)color{
    [self setTitleColor:color font:nil titleShadowColor:nil shadowOffset:CGSizeZero];
}
-(void)setTitleColor:(UIColor *)color font:(UIFont *)font titleShadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset{
    {
        //设置字体颜色
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 0) forBarMetrics:UIBarMetricsDefault];
        
        [[UINavigationBar appearance] setTintColor:color];
        
        NSMutableDictionary *attributes =[[NSMutableDictionary alloc] init];
        
        if(color)
            [attributes setObject:color forKey:NSForegroundColorAttributeName];
        
        if(font)
            [attributes setObject:font forKey:NSFontAttributeName];
        
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = shadowColor;
        shadow.shadowOffset = shadowOffset;
        
        [attributes setObject:shadow forKey:NSShadowAttributeName];
        
        [self setTitleTextAttributes:attributes];
    }
    
    
}



@end
