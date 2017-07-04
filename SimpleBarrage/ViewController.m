//
//  ViewController.m
//  SimpleBarrage
//
//  Created by FC on 2017/5/15.
//  Copyright © 2017年 God bless never bug. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)NSMutableArray * StrArray;
@property(nonatomic,strong)NSMutableArray * HeightArray;
@property(nonatomic,strong)NSTimer * repateTimer;
@property(nonatomic,strong)NSTimer * loadTimer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
}
-(void)loadData{
    self.StrArray=[[NSMutableArray alloc]init];
    for (int i = 0;i<30; i++){
        [self.StrArray addObject:[NSString stringWithFormat:@"===-=%d---=-",arc4random() % 100000]];
    }
    //设置一个计时器，每隔一段时间就会产生一个label
//    这个地方的重复时间越小 重叠的几率越大 1 刚刚好
    _repateTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(initDate) userInfo:nil repeats:YES];
    
}

-(void)move:(UIView*)_label
{
    [UIView animateWithDuration:8 animations:^{
        _label.frame = CGRectMake(-250, _label.frame.origin.y, _label.frame.size.width, _label.frame.size.height);
    } completion:^(BOOL finished) {
        [_label removeFromSuperview];
    }
     ];
}

//需要改变的三个地方，label :文本颜色，位置，文本的内容。
-(void)initDate
{
    if (self.StrArray.count<=1){
        [self.repateTimer invalidate];
        self.repateTimer=nil;
        [self.StrArray removeAllObjects];
        [self loadData];
        return;
    }
    [self.StrArray removeObjectAtIndex:0];
    
    int i=rand()%self.StrArray.count;
    NSString *str = [self.StrArray objectAtIndex:i];
    ///只要有肉眼能看到的视图，都是以ui开头的
    //实例化一个标签，（用于现实文字）
    
    UIView * bgview=[[UIView alloc]initWithFrame:CGRectMake(480, rand()%240, 250, 23)];
    UIImageView * icon=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [icon setImage:[UIImage imageNamed:@"123"]];
    UILabel *label = [[UILabel alloc]init];
    //指定位置和大小。
    label.frame =CGRectMake(icon.frame.origin.x+icon.frame.size.width+5, 5, 230, 23);
    label.text = str;
    label.textColor = [self randomColor];
    [bgview addSubview:icon];
    [bgview addSubview:label];
    //将label加入本视图中去。
    [self.view addSubview:bgview];
    //让生成的label传入下面的move函数中去。
    [self move:bgview];
    
}
////默认显示弹幕的高度是300
//-(NSArray *)HeightArray{
//    int rowheight=200;
//    _HeightArray=[[NSMutableArray alloc]init];
//    for(int i=0;i<rowheight/30;i++){
//        NSString * str=[NSString stringWithFormat:@"%d",30*i];
//        [_HeightArray addObject:str];
//    }
//    
//    return _HeightArray;
//}
-(UIColor *)randomColor
{
    /*
     颜色有两种表现形式 RGB RGBA
     RGB 24
     R,G,B每个颜色通道8位
     8的二进制 255
     R,G,B每个颜色取值 0 ~255
     120 / 255.0
     
     */
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


@end
