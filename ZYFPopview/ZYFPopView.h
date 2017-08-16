//
//  ZYFPopView.h
//  ZYFPopview
//
//  Created by moxi on 2017/8/11.
//  Copyright © 2017年 zyf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZYFPopViewStyle){
    
    ZYFPopViewStyleTop = 0,
    ZYFPopViewStyleBottom ,
    ZYFPopViewStyleCenter
};

typedef void (^OnMSStringViewDoneBlock) (NSInteger selectIndex);
typedef void (^OnMSStringViewCancleBlock)();

@interface ZYFPopView : UIView

@property (nonatomic, copy)OnMSStringViewDoneBlock onDoneBlock;
@property (nonatomic, copy)OnMSStringViewCancleBlock onCancleBlock;

-(instancetype)initInView:(UIView *)hostView style:(ZYFPopViewStyle)style images:(NSMutableArray*)images rows:(NSMutableArray*)items doneBlock:(void(^)(NSInteger selectIndex))ondoneBlock cancleBlock:(void(^)())cancleBlock;

-(void)showPopView;

@end
