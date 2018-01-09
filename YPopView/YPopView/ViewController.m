//
//  ViewController.m
//  YPopView
//
//  Created by shusy on 2018/1/9.
//  Copyright © 2018年 杭州爱卿科技. All rights reserved.
//

#import "ViewController.h"
#import "YPopView.h"

@interface ViewController ()
@property(nonatomic,strong)YPopView *pop;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    YPopView *pop = [[YPopView alloc] initWithTitle:@"提示" descTitle:@"福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚款决定书福豆是罚"];
    self.pop = pop;
    [pop setTitleFont:15 titleColor:[UIColor redColor] descFont:14 descColor:[UIColor purpleColor] lineSpacing:5 lineHeight:5];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.pop show];
}



@end
