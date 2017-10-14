//
//  CATextLayerVC.m
//  CoreAnimationTest
//
//  Created by mengkezheng on 2017/9/18.
//  Copyright © 2017年 com.qudao. All rights reserved.
//

#import "CATextLayerVC.h"
#import <CoreText/CoreText.h>


@interface LayerLabel : UILabel

@end

@implementation LayerLabel

+ (Class)layerClass{
    return [CATextLayer class];
}

- (CATextLayer *)textLayer{
    return (CATextLayer *)self.layer;
}

- (void)setUp{
    //set defaults from UILabel settings
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    
    //we should really derive these from the UILabel settings too
    //but that's complicated, so for now we'll just hard-code them
    [self textLayer].alignmentMode = kCAAlignmentJustified;
    
    [self textLayer].wrapped = YES;
    [self.layer display];
}

- (id)initWithFrame:(CGRect)frame
{
    //called when creating label programmatically
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    //called when creating label using Interface Builder
    [self setUp];
    [super awakeFromNib];
}

- (void)setText:(NSString *)text{
    super.text = text;
    [self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor{
    super.textColor = textColor;
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font{
    super.font = font;
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    
    CGFontRelease(fontRef);
}



@end


@interface CATextLayerVC ()

@end

@implementation CATextLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //普通文本
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(100, 70, 200, 200);
    [self.view.layer addSublayer:textLayer];
    
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    NSString *text = @"显示中文为什么比英文费劲Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar  leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel  fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet  lobortis";
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.truncationMode = kCATruncationEnd;
    textLayer.string = text;
    
    //富文本
    {
        //create a text layer
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.frame = CGRectMake(100, 300, 200, 200);
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.view.layer addSublayer:textLayer];
        
        //set text attributes
        textLayer.alignmentMode = kCAAlignmentJustified;
        textLayer.wrapped = YES;
        
        //choose a font
        UIFont *font = [UIFont systemFontOfSize:15];
        
        //choose some text
        NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet lobortis";
        
        //create attributed string
        NSMutableAttributedString *string = nil;
        string = [[NSMutableAttributedString alloc] initWithString:text];
        
        //convert UIFont to a CTFont
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFloat fontSize = font.pointSize;
        CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
        
        //set text attributes
        NSDictionary *attribs = @{
                                  (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
                                  (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                                  };
        
        [string setAttributes:attribs range:NSMakeRange(0, [text length])];
        attribs = @{
                    (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
                    (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                    (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                    };
        [string setAttributes:attribs range:NSMakeRange(6, 5)];
        
        //release the CTFont we created earlier
        CFRelease(fontRef);
        
        //set layer text
        textLayer.string = string;
    }
    
    //layer label
    LayerLabel *label = [[LayerLabel alloc]initWithFrame:CGRectMake(100, 520, 200, 200)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet lobortis";
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


