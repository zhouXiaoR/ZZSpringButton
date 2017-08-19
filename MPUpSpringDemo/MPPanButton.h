//
//  MPPanButton.h
//  MPUpSpringDemo
//
//  Created by 周晓瑞 on 2017/3/29.
//  Copyright © 2017年 colleny. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE  // 动态刷新

@interface MPPanButton : UIButton

// 注意: 加上IBInspectable就可以可视化显示相关的属性
/** 可视化设置边框宽度 */
@property (nonatomic, assign)IBInspectable CGFloat borderZXWidth;
/** 可视化设置边框颜色 */
@property (nonatomic, strong)IBInspectable UIColor *borderColor;
/** 可视化设置圆角 */
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;

@end
