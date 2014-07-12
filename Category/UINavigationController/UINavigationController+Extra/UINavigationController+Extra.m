//
//  UINavigationController+Custom.m 
//

#import "UINavigationController+Extra.h"
#import <objc/runtime.h>

@implementation UINavigationController(Navigation)

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

-(UIViewController *)currentViewController{
    UIViewController  *controller= [self.viewControllers lastObject];
    return controller;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return [[self currentViewController] shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}
- (BOOL)shouldAutorotate{
    return [[self currentViewController] shouldAutorotate];
}
- (NSUInteger)supportedInterfaceOrientations{
    return [[self currentViewController] supportedInterfaceOrientations];
}

@end

@implementation UINavigationItem(Extra)

static const char *indicatorImageKey      ="__indicatorImageKey__";
static const char *indicatorHighlightedImageKey      ="__indicatorHighlightedImageKey__";

-(void)setIndicatorImage:(UIImage *)indicatorImage{
    objc_setAssociatedObject(self, indicatorImageKey, indicatorImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIImage *)indicatorImage{
    return objc_getAssociatedObject(self, indicatorImageKey);
}
-(void)setIndicatorHighlightedImage:(UIImage *)indicatorHighlightedImage{
    objc_setAssociatedObject(self, indicatorHighlightedImageKey, indicatorHighlightedImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIImage *)indicatorHighlightedImage{
    return objc_getAssociatedObject(self, indicatorHighlightedImageKey);
}
-(void)dealloc{
    
    objc_removeAssociatedObjects(self);
    
}

- (void)setLeftBarButtonTitle:(NSString *)title target:(id)target action:(SEL)action indicator:(BOOL)indicator{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIFont *font = [UIFont boldSystemFontOfSize:14.0f];
    
    button.titleLabel.font =font;
    button.backgroundColor=[UIColor clearColor];
    
    
    
    CGSize titleSize;
    if([UIDevice currentDevice].systemVersion.floatValue<7.0f){
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        titleSize = [title sizeWithFont:button.titleLabel.font];
#endif
        
    }else{
        NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys: button.titleLabel.font, NSFontAttributeName, nil];
        titleSize= [title  boundingRectWithSize: CGSizeMake(270, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context: nil].size;
    }
    
    UIImage *image = nil;
    if(indicator){
        image = self.indicatorImage;
        
        CGFloat titleLeftInset = 0.0f;
        if([UIDevice currentDevice].systemVersion.floatValue>=7.0f){
            titleLeftInset = 20;
        }else{
            titleLeftInset = 10;
        }
        
        if([UIDevice currentDevice].systemVersion.floatValue>=7.0f){
            [button setImageEdgeInsets:UIEdgeInsetsMake(2.0,
                                                        -titleLeftInset,
                                                        0.0,
                                                        0.0)];
        }else{
            [button setImageEdgeInsets:UIEdgeInsetsMake(2.0,
                                                        -titleLeftInset,
                                                        0.0,
                                                        0.0)];
        }
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:self.indicatorHighlightedImage forState:UIControlStateHighlighted];
        
        button.frame = CGRectMake(0, 0, titleSize.width+image.size.width+20, 43);
        
    }else{
        button.frame = CGRectMake(0, 0, titleSize.width+20, 43);
        
    }
    button.titleLabel.textAlignment=NSTextAlignmentLeft;
    [button.titleLabel setBackgroundColor:[UIColor clearColor]];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:1.000 alpha:0.330] forState:UIControlStateHighlighted];
    
    CGFloat titleInset = 0.0f;
    if (indicator) {
        if([UIDevice currentDevice].systemVersion.floatValue>=7.0f){
            titleInset = 10;
        }
    }else{
        if([UIDevice currentDevice].systemVersion.floatValue>=7.0f){
            titleInset = 20;
        }
    }
    
    
    [button setTitleEdgeInsets:UIEdgeInsetsMake(2.0,
                                                -titleInset,
                                                0.0,
                                                0.0)];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self setLeftBarButtonItem:barButtonItem animated:YES];
}

- (void)setLeftBarButtonImage:(UIImage *)image target:(id)target action:(SEL)action{
    
}

- (void)setLeftBarButton:(UIButton *)button{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self setLeftBarButtonItem:barButtonItem animated:YES];
    
}

- (void)setRightBarButtonTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0.0, 0.0, 80.0, 27.0);
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [rightButton setTitleColor:[UIColor colorWithWhite:1.000 alpha:0.330] forState:UIControlStateHighlighted];
    rightButton.titleLabel.font=[UIFont boldSystemFontOfSize:14.0f];
    
    CGSize fontSize;
    if([UIDevice currentDevice].systemVersion.floatValue<7.0f){
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        fontSize = [title sizeWithFont:rightButton.titleLabel.font];
#endif
        
    }else{
        NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys: rightButton.titleLabel.font, NSFontAttributeName, nil];
        fontSize= [title  boundingRectWithSize: CGSizeMake(270, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context: nil].size;
    }
    
    CGFloat rightInset = 0.0f;
    if([UIDevice currentDevice].systemVersion.floatValue>=7.0f){
        rightInset = 80 - fontSize.width;
    }else{
        rightInset = 60 - fontSize.width;
    }
    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(2.0,
                                                     0.0,
                                                     0.0,
                                                     -rightInset)];
    
    
    
    [rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.rightBarButtonItem=rightButtonItem;
}

- (void)setRightBarButtonImage:(UIImage *)image target:(id)target action:(SEL)action{
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor =[UIColor clearColor];
    
    button.frame = CGRectMake(0.0, 0.0, 60, 27.0);
    
    CGFloat rightInset = 0.0f;
    
    if([UIDevice currentDevice].systemVersion.floatValue>=7.0f){
        rightInset = 60 - image.size.width;;
    }else{
        rightInset = 40 - image.size.width;
    }
    if (rightInset<0) {
        rightInset=0;
    }
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(2.0,
                                                0.0,
                                                0.0,
                                                -rightInset)];
    
    [button setImage:image forState:UIControlStateNormal];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.rightBarButtonItem=barButtonItem;
    
}
- (void)setRightBarButton:(UIButton *)button{
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.rightBarButtonItem=barButtonItem;
    
}


@end

@implementation UINavigationBar (Extra)

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
