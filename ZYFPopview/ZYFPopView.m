//
//  ZYFPopView.m
//  ZYFPopview
//
//  Created by moxi on 2017/8/11.
//  Copyright © 2017年 zyf. All rights reserved.
//

#import "ZYFPopView.h"
#import "Masonry.h"

@interface ZYFPopView ()

@property (nonatomic, strong)UIView *hostView;

@property (nonatomic, strong) UIView *shadeView;
@property (nonatomic, strong)UIView *popBaseView;

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *data;


@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic,strong)UIButton *cancleButton;

@property (nonatomic, assign)ZYFPopViewStyle popviewStyle;
@property (nonatomic, assign)CGRect popViewStart;
@property (nonatomic, assign)CGRect popViewEnd;


@end



@implementation ZYFPopView


-(instancetype)initInView:(UIView *)hostView style:(ZYFPopViewStyle)style images:(NSMutableArray*)images rows:(NSMutableArray*)items doneBlock:(void(^)(NSInteger selectIndex))ondoneBlock cancleBlock:(void(^)())cancleBlock{
    
    self = [super initWithFrame:hostView.bounds];
    if (self) {
        self.hostView = hostView;
        self.data = items;
        self.images = images;
        self.popviewStyle = style;
        self.onDoneBlock = ondoneBlock;
        self.onCancleBlock = cancleBlock;
        
        [self setupView];
    }
    return self;
}

-(void)setupView{
    
    if (!self.shadeView) {
        self.shadeView = [[UIView alloc]initWithFrame:self.bounds];
        self.shadeView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
        [self.shadeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
        [self addSubview:self.shadeView];
    }
    
    
    if (!self.popBaseView) {
        
        switch (self.popviewStyle) {
            case ZYFPopViewStyleTop:
            {
                self.popViewStart = CGRectMake(0, -100, self.bounds.size.width, 120);
                self.popViewEnd = CGRectMake(0, 0, self.bounds.size.width, 120);
                
            }
                break;
            case ZYFPopViewStyleBottom:
            {
                self.popViewStart = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 120);
                self.popViewEnd = CGRectMake(0, self.bounds.size.height - 120, self.bounds.size.width, 120);
            }
                break;
            case ZYFPopViewStyleCenter:
            {
                self.popViewStart = CGRectMake(0, -120, self.bounds.size.width, 120);
                self.popViewEnd = CGRectMake(0, self.bounds.size.height/2 - 60, self.bounds.size.width, 120);
            }
                break;
                
            default:
                break;
        }
        [self showPopViewWithStart:self.popViewStart end:self.popViewEnd];
 
    }
    
}

-(void)showPopView{
    if (self.hostView) {
        [self.hostView addSubview:self];
    }
}


-(void)showPopViewWithStart:(CGRect)start end:(CGRect)end{
    
    self.popBaseView = [[UIView alloc]initWithFrame:start];
    self.popBaseView.backgroundColor = [UIColor whiteColor];
    [self.shadeView addSubview:self.popBaseView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.popBaseView.frame = end;
    }];
    
    CGFloat cancelTop = 0.0;
    
    if(self.data.count > 0){
        
        CGFloat btnHeight = 64;
        CGFloat padding;
        if (self.popviewStyle == ZYFPopViewStyleTop) {
            padding = 50;
            cancelTop = 20;
        }else{
            padding = 38;
            cancelTop = 0;
        }
        CGFloat btnWidth = 50;
        CGFloat edgeMargin = (self.bounds.size.width - self.data.count * btnWidth) / (self.data.count + 1);
        CGFloat spacing = 5.0f;
        
        for (int i = 0; i < self.data.count; i++) {
            
            
            UIButton *button = [UIButton new];
            button.tag = i;
            [button setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
            [button setTitle:self.data[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            [button addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.popBaseView addSubview:button];
            
            CGSize imageSize = button.imageView.image.size;
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(imageSize.height + spacing), 0);
            
            CGSize titleSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
            button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0, 0, -titleSize.width);
            
            CGFloat edgeOffset = fabs(titleSize.height - imageSize.height) / 2.0f;
            button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0, edgeOffset, 0);
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(edgeMargin + i * (edgeMargin + btnWidth));
                make.width.mas_equalTo(btnHeight - 10);
                make.height.mas_equalTo(btnHeight);
                make.top.mas_equalTo(self.popBaseView.mas_top).offset(padding);
            }];
            
            
        }
    }
    
    if (!self.cancleButton) {
        self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancleButton.backgroundColor = [UIColor whiteColor];
        [self.cancleButton setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [self.cancleButton addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.popBaseView addSubview:self.cancleButton];
        
        [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.popBaseView.mas_top).offset(cancelTop);
            make.right.mas_equalTo(self.popBaseView.mas_right).offset(-5);
            make.height.mas_equalTo(32);
            make.width.mas_equalTo(32);
        }];
        
    }

}

#pragma mark -tap

-(void)handleTapGesture:(UITapGestureRecognizer*)tap{
    [UIView animateWithDuration:0.3 animations:^{
        self.popBaseView.frame = self.popViewStart;
        
    } completion:^(BOOL finished) {
        self.shadeView.alpha = 0;
        [self removeFromSuperview];
    }];
}

#pragma mark -click


-(void)cancleClick:(UIButton*)button{
    
   if (self.onCancleBlock) {
       
       self.onCancleBlock();
       
       if (self.popviewStyle == ZYFPopViewStyleCenter) {
           self.popViewStart = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 120);
       }
       [UIView animateWithDuration:0.3 animations:^{
            self.popBaseView.frame = self.popViewStart;
           
        } completion:^(BOOL finished) {
            self.shadeView.alpha = 0;
            [self removeFromSuperview];
        }];
    }
}

-(void)actionClick:(UIButton*)button{
    
    if (self.onDoneBlock) {
        
        self.onDoneBlock(button.tag);
        
        if (self.popviewStyle == ZYFPopViewStyleCenter) {
            self.popViewStart = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 120);
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            self.popBaseView.frame = self.popViewStart;
            
        } completion:^(BOOL finished) {
            self.shadeView.alpha = 0;
            [self removeFromSuperview];
        }];
    }
    
}


@end
