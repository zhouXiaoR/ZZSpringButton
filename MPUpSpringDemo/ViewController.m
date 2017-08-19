//
//  ViewController.m
//  MPUpSpringDemo
//
//  Created by 周晓瑞 on 2017/3/29.
//  Copyright © 2017年 colleny. All rights reserved.
//

#import "ViewController.h"
#import "NSURLSessionDataTask+reCount.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSObject * nob = [NSObject new];
    NSURLSessionDataTask * obj = [NSURLSessionDataTask new];
    
    
    obj.netXXCount = 10;
    
    NSLog(@"kkk---%@",NSStringFromClass(obj.class));
    
    NSInteger i = 0;
    i++;
    obj.netXXCount = i;

    NSLog(@"kkk---%d",obj.netXXCount);

}
- (void)safeArrayTest{
    
    
    NSArray *tempArray = @[];
    NSString *str = tempArray[10];
    
    NSArray *array = @[@"a", @"b"];
    NSMutableArray *mutableArray = [@[@"aa", @"bb"] mutableCopy];
    
    // Object at index
    NSLog(@"%@", array[10]);
    NSLog(@"%@", mutableArray[100]);
    
    // add object
    NSString *nilString;
    [mutableArray addObject:nilString];
    
    // Insert object
    [mutableArray insertObject:nilString atIndex:0];
    [mutableArray insertObject:@"cc" atIndex:10];
    
    // Replace object
    [mutableArray replaceObjectAtIndex:0 withObject:nilString];
    [mutableArray replaceObjectAtIndex:10 withObject:@"cc"];
    
    // Dictionary
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionary];
    mutableDictionary[nilString] = @"1";
    mutableDictionary[@"1"] = nilString;
    
    
    

}

- (void)attributeLab{
    NSString *updateMsg = @"我是我我我我我我我我我我我我我我我旬kasd；是地；芝加哥百栽；ldjf；哩；百苛；加厚地；困惑百；协；中西医结合三轮哥； 要；大跃进框架；jdfl；工地；dfas；艺术团；要；虹；工；檌我是我我我我我我我我、民\n我我我我我我我旬kasd；是地；芝加哥百栽；ldjf；哩；百苛；加厚地；困惑百；协；中西医结合三轮哥";
    CGFloat h = [self getTxtHeightContent:updateMsg font:14 lineSpace:5 width:240 paragraphSpaceing:0];
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 240, h)];
    lab.backgroundColor = [UIColor redColor];
    lab.font = [UIFont systemFontOfSize:14];
    lab.numberOfLines = 0;
    lab.attributedText = [self attributeStringContent:updateMsg font:14 lineSpace:5 paragraphSpaceing:0];
    [self.view addSubview:lab];
}
- (CGFloat)getTxtHeightContent:(NSString *)content font:(CGFloat)fontValue lineSpace:(CGFloat)lineSpaceValue width:(CGFloat)width paragraphSpaceing:(CGFloat)paraSpace
{
    if(!content||content.length<=0)
        return 0;
    
    CGFloat  reFontValue = 12;
    CGFloat  reLineSpaceValue = 4;
    CGFloat reWidth = self.view.bounds.size.width;
    CGFloat chartorSpace = 1.5f;
    
    if(fontValue>0)
        reFontValue = fontValue;
    
    if(reLineSpaceValue>0)
        reLineSpaceValue=lineSpaceValue;
    
    if(reWidth>0)
        reWidth=width;
    
    CGFloat reuHeight = 0;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = reLineSpaceValue;
    style.lineBreakMode = NSLineBreakByCharWrapping;
    style.alignment = NSTextAlignmentLeft;
    if (paraSpace>0) {
        style.paragraphSpacing = paraSpace;
    }
    
    CGSize size = [content  boundingRectWithSize:CGSizeMake(reWidth,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:reFontValue],NSParagraphStyleAttributeName:style,NSKernAttributeName:[NSNumber numberWithFloat:chartorSpace]} context:nil].size;
    
    if(size.height>0)
        reuHeight = size.height;
    
    return reuHeight;
}

- (NSMutableAttributedString*)attributeStringContent:(NSString *)cLabelString font:(CGFloat)fontValue lineSpace:(CGFloat)lineSpaceValue paragraphSpaceing:(CGFloat)paraSpace
{
    if(!cLabelString||cLabelString.length<=0)
        return nil;
    
    CGFloat  reFontValue = 12;
    CGFloat  reLineSpaceValue = 4;
    CGFloat chartorSpace = 1.5f;
    
    if(fontValue>0)
        reFontValue = fontValue;
    
    if(reLineSpaceValue>0)
        reLineSpaceValue=lineSpaceValue;
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:cLabelString];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    if (paraSpace>0) {
        paragraphStyle1.paragraphSpacing = paraSpace;
    }
    [paragraphStyle1 setLineSpacing:reLineSpaceValue];
    paragraphStyle1.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle1.alignment = NSTextAlignmentLeft;
    [attributedString1 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:reFontValue],NSParagraphStyleAttributeName:paragraphStyle1,NSKernAttributeName:[NSNumber numberWithFloat:chartorSpace]} range:NSMakeRange(0, [cLabelString length])];
    return attributedString1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
