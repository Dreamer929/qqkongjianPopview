//
//  ViewController.m
//  ZYFPopview
//
//  Created by moxi on 2017/8/11.
//  Copyright © 2017年 zyf. All rights reserved.
//

#import "ViewController.h"
#import "ZYFPopView.h"

@interface ViewController ()

@property (nonatomic, strong)ZYFPopView *popView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showTopClick:(id)sender {
    
    [self popview:ZYFPopViewStyleTop];
}

- (IBAction)showBottomClick:(id)sender {
    
    [self popview:ZYFPopViewStyleBottom];
    
}

- (IBAction)showCenterClick:(id)sender {
    
    [self popview:ZYFPopViewStyleCenter];
}

- (IBAction)showCenterAnimationClick:(id)sender {
}

-(void)popview:(ZYFPopViewStyle)style{
    
    NSInteger i = 1;
    if(i){
        self.popView = [[ZYFPopView alloc]initInView:[UIApplication sharedApplication].keyWindow style:style images:(NSMutableArray*)@[@"alipay",@"baidu",@"sm"] rows:(NSMutableArray*)@[@"12",@"sina",@"sm"] doneBlock:^(NSInteger selectIndex) {
            
            NSLog(@"%ld",selectIndex);
            
        } cancleBlock:^{
            
        }];
    }else{
        self.popView = [[ZYFPopView alloc]initInView:[UIApplication sharedApplication].keyWindow style:style images:(NSMutableArray*)@[@"tz",@"sina",@"gg",@"weChat",@"qq",@"sp"] rows:(NSMutableArray*)@[@"12",@"sina",@"gg",@"we",@"QQ",@"sp"] doneBlock:^(NSInteger selectIndex) {
            
            NSLog(@"%ld",selectIndex);
            
        } cancleBlock:^{
            
        }];
    }
    
   
    
    
    
    [self.popView showPopView];
    
}

@end
