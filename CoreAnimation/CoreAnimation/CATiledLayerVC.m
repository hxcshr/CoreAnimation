//
//  CATiledLayerVC.m
//  CoreAnimation
//
//  Created by 何学成 on 2017/9/19.
//  Copyright © 2017年 qudao.tbkf.net. All rights reserved.
//
/*
 
 CATiledLayer为载入大图造成的性能问题提供了一个解决方案：将大图分解成小片然后将他们单独按需载入。地图应该就是用它实现的
 
 //把大图切割为小图的方法
 #import
 
 int main(int argc, const char * argv[])
 {
 @autoreleasepool{
 ￼//handle incorrect arguments
 if (argc < 2) {
 NSLog(@"TileCutter arguments: inputfile");
 return 0;
 }
 
 //input file
 NSString *inputFile = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
 
 //tile size
 CGFloat tileSize = 256; //output path
 NSString *outputPath = [inputFile stringByDeletingPathExtension];
 
 //load image
 NSImage *image = [[NSImage alloc] initWithContentsOfFile:inputFile];
 NSSize size = [image size];
 NSArray *representations = [image representations];
 if ([representations count]){
 NSBitmapImageRep *representation = representations[0];
 size.width = [representation pixelsWide];
 size.height = [representation pixelsHigh];
 }
 NSRect rect = NSMakeRect(0.0, 0.0, size.width, size.height);
 CGImageRef imageRef = [image CGImageForProposedRect:&rect context:NULL hints:nil];
 
 //calculate rows and columns
 NSInteger rows = ceil(size.height / tileSize);
 NSInteger cols = ceil(size.width / tileSize);
 
 //generate tiles
 for (int y = 0; y < rows; ++y) {
 for (int x = 0; x < cols; ++x) {
 //extract tile image
 CGRect tileRect = CGRectMake(x*tileSize, y*tileSize, tileSize, tileSize);
 CGImageRef tileImage = CGImageCreateWithImageInRect(imageRef, tileRect);
 
 //convert to jpeg data
 NSBitmapImageRep *imageRep = [[NSBitmapImageRep alloc] initWithCGImage:tileImage];
 NSData *data = [imageRep representationUsingType: NSJPEGFileType properties:nil];
 CGImageRelease(tileImage);
 
 //save file
 NSString *path = [outputPath stringByAppendingFormat: @"_%02i_%02i.jpg", x, y];
 [data writeToFile:path atomically:NO];
 }
 }
 }
 return 0;
 }
 */

#import "CATiledLayerVC.h"

@interface CATiledLayerVC ()<CALayerDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation CATiledLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    
    CATiledLayer *tileLayer = [CATiledLayer layer];
    tileLayer.frame = CGRectMake(0, 0, 2048, 2048);
    tileLayer.delegate = self;
    
    self.scrollView.contentSize = tileLayer.frame.size;
    
    [tileLayer setNeedsDisplay];
    
}

- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx{
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    NSInteger x = floor(bounds.origin.x / layer.tileSize.width);
    NSInteger y = floor(bounds.origin.y / layer.tileSize.height);
    
    NSString *imageName = [NSString stringWithFormat: @"Snowman_%02ld_%02ld", x, y];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
    UIImage *tileImage = [UIImage imageWithContentsOfFile:imagePath];
    
    UIGraphicsPushContext(ctx);
    [tileImage drawInRect:bounds];
    UIGraphicsPopContext();
}

@end
