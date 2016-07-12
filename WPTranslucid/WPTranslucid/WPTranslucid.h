//
//  WPTranslucid.h
//  WPTranslucid
//
//  Created by wupeng on 16/7/12.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPTranslucid : UIView
@property (nonatomic,copy) IBInspectable NSString *text;
@property (nonatomic,assign) IBInspectable CGFloat fontSize;
@property (nonatomic,strong) IBInspectable UIImage *bgImage;
@end
