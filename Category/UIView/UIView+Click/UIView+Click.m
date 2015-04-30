//
//  UIView+Control.m
//  mvoice
//
//  Created by yangjunhai on 14-7-12.
//  Copyright (c) 2014年 soooner. All rights reserved.
//

#import "UIView+Click.h"
#import <objc/runtime.h>


@implementation UIView (Click)

static const char *UIView_Click_Control             ="__UIView_Click_Control__";
static const char *UIView_Click_ControlKey          ="__UIView_Click_ControlKey__";
static const char *UIView_Click_ControlKeyStr       ="__UIView_Click_ControlKeyStr__";

static const char *UIView_Click_Target              ="__UIView_Click_Target__";
static const char *UIView_Click_SEL                 ="__UIView_Click_SEL__";


-(void)setAdditionControlKey:(NSInteger)controlKey{
    objc_setAssociatedObject(self, UIView_Click_ControlKey, [NSNumber numberWithInteger:controlKey], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSInteger)additionControlKey{
    NSNumber *_controlKey = objc_getAssociatedObject(self, UIView_Click_ControlKey);
     return [_controlKey integerValue];
}

-(void)setAdditionControlKeyStr:(NSString *)controlKeyStr{
    objc_setAssociatedObject(self, UIView_Click_ControlKeyStr, controlKeyStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSString *)additionControlKeyStr{
    return objc_getAssociatedObject(self, UIView_Click_ControlKeyStr);
}


- (void)addExtendClickTarget:(id)target action:(SEL)action{
    UIControl *_control=[self extActionControl];
    
    NSString *selStr =NSStringFromSelector(action);
    
    [self setExtActionControlAction:selStr];
    [self setExtActionControlTarget:target];
    
    if(!_control){
        self.userInteractionEnabled =YES;
        _control=[[UIControl alloc] initWithFrame:self.bounds];
        _control.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self addSubview:_control];
        [_control sendSubviewToBack:self];
        [self setExtActionControl:_control];
        [_control addTarget:self action:@selector(sblt_extExtendClickActionImageDown:) forControlEvents:UIControlEventTouchDown];
        [_control addTarget:self action:@selector(sblt_extExtendClickActionImageUp:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchCancel|UIControlEventTouchUpOutside|UIControlEventTouchDragOutside];
        [_control addTarget:self action:@selector(sblt_extExtendClickActionImageAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

- (void)removeExtendClickTarget:(id)target action:(SEL)action{
    UIControl *_control=[self extActionControl];
    [_control removeTarget:self action:@selector(sblt_extExtendClickActionImageDown:) forControlEvents:UIControlEventTouchDown];
    [_control removeTarget:self action:@selector(sblt_extExtendClickActionImageUp:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchCancel|UIControlEventTouchUpOutside|UIControlEventTouchDragOutside];
    [_control removeTarget:self action:@selector(sblt_extExtendClickActionImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setExtActionControl:nil];
    
}

 

#pragma mark - private method
-(void)setExtActionControl:(UIControl *)control{
    objc_setAssociatedObject(self, UIView_Click_Control, control, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIControl *)extActionControl{
    return objc_getAssociatedObject(self, UIView_Click_Control);
}

-(void)setExtActionControlTarget:(id)target{
    objc_setAssociatedObject(self, UIView_Click_Target, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)extActionControlTarget{
    return objc_getAssociatedObject(self, UIView_Click_Target);
}

-(void)setExtActionControlAction:(NSString *)action{
    objc_setAssociatedObject(self, UIView_Click_SEL, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)extActionControlAction{
    return objc_getAssociatedObject(self, UIView_Click_SEL);
}



-(void)sblt_extExtendClickActionImageUp:(UIControl *)control{
    control.backgroundColor =[UIColor clearColor];
}
-(void)sblt_extExtendClickActionImageDown:(UIControl *)control{
    control.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.4f];
}
-(void)sblt_extExtendClickActionImageAction:(UIControl *)control{
    
    SEL sel = NSSelectorFromString([self extActionControlAction]);
    id target = [self extActionControlTarget];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [target performSelector:sel withObject:self];
#pragma clang diagnostic pop
    
}

-(void)dealloc{
    
    if([self extActionControl]){
        [[self extActionControl] removeFromSuperview];
        [self setExtActionControl:nil];
    }
    
    objc_removeAssociatedObjects(self);
    
}


@end
