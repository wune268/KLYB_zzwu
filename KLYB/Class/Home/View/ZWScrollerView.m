//
//  ZWScrollerView.m
//  KLYB
//
//  Created by ZZWU on 15/12/9.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWScrollerView.h"
#import "ZWActivity.h"
#import "ZWCommodityDetails.h"

@interface ZWScrollerView ()

@property(nonatomic,strong)NSArray *imageArray;
//@property(nonatomic,weak)NSMutableArray *titleArray;
@property(nonatomic,weak)UIScrollView *scrollView;
@property (weak, nonatomic)UIPageControl *pageControl;

//@property(nonatomic,assign)NSInteger *type;

/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZWScrollerView

-(id)initWithFrameRect:(CGRect)frame
            scrolArray:(NSArray *)array
                  type:(NSInteger)type
{
    if (self=[super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        NSUInteger pageCount = array.count;
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(frame.size.width * pageCount, frame.size.height);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        scrollView.backgroundColor=[UIColor clearColor];
        self.scrollView = scrollView;
        self.imageArray = array;
        WuLog(@"imageArray-----%@",array);
        for (int i = 0; i < array.count; i++)
        {
            if (type == 0) {
                ZWActivity *activity = array[i];
                UIImageView *imgView = [[UIImageView alloc] init];
                [imgView setFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
                imgView.tag = i;
                imgView.backgroundColor = [UIColor grayColor];
                [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",httpResourcesAddress, activity.imgUrl]] placeholderImage:[UIImage imageNamed:@"default_01"]];
                imgView.contentMode = UIViewContentModeScaleToFill;
                
                UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wu_imagePressed:)];
                imgView.userInteractionEnabled = YES;
                [imgView addGestureRecognizer:Tap];
                [scrollView addSubview:imgView];
            }
            else if (type == 1)
            {
                
//                ZWCommodityDetails *commodityDetails = array[i];
                NSString *imageName = [NSString stringWithFormat:@"%@", array[i]];
                UIImageView *imgView = [[UIImageView alloc] init];
                [imgView setFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
                imgView.tag = i;
                imgView.backgroundColor = [UIColor grayColor];
                [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",httpResourcesAddress, imageName]] placeholderImage:[UIImage imageNamed:@"default_01"]];
                imgView.contentMode = UIViewContentModeScaleToFill;
                [scrollView addSubview:imgView];
            }
        }
        
        [self addSubview:scrollView];
        
        //说明文字层
//        UIView *noteView=[[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 25,self.bounds.size.width, 25)];
//        noteView.backgroundColor = [UIColor  colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        float pageControlWidth = pageCount * 10;
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(scrollView.frame.size.width - pageControlWidth - 20,scrollView.frame.size.height - 15, pageControlWidth,10)];
        pageControl.currentPage = 0;
        if (pageCount > 1)
        {
            pageControl.currentPageIndicatorTintColor=[UIColor redColor];
        }
        else
        {
            pageControl.currentPageIndicatorTintColor=[UIColor redColor];
        }
        pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        pageControl.numberOfPages = pageCount;
        
        self.pageControl = pageControl;
        
        
//        UILabel *noteTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width - pageControlWidth - 80, 25)];
        [self addSubview:scrollView];
        [self addSubview:pageControl];
        
//        if(isNeedTitle)
//        {
//            if(titleArray.count > 0)
//            {
//                NSString *str = [titleArray objectAtIndex:0];
//                noteTitle.text = str;
//                [noteTitle setBackgroundColor:[UIColor  colorWithRed:.95 green:.95 blue:.95 alpha:1.0]];
//                [noteTitle setFont:[UIFont systemFontOfSize:13]];
//                noteTitle.textColor = [UIColor grayColor];
//                [noteView addSubview:noteTitle];
//            }
//        }
        [self wu_addTimer];
    }
    return self;
}

-(NSArray *)imageArray
{
    if (_imageArray == nil) {
        NSArray *array = [NSArray array];
        _imageArray = array;
    }
    return _imageArray;
}

/**
 *  添加定时器
 */
- (void)wu_addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(wu_nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)wu_removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)wu_nextImage
{
    // 1.增加pageControl的页码
    NSInteger page = 0;
    if (self.pageControl.currentPage == self.imageArray.count - 1) {
        page = 0;
    } else {
        page = self.pageControl.currentPage + 1;
    }
    
    // 2.计算scrollView滚动的位置
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - 代理方法
/**
 *  当scrollView正在滚动就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 根据scrollView的滚动位置决定pageControl显示第几页
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    self.pageControl.currentPage = page;
}

/**
 *  开始拖拽的时候调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止定时器(一旦定时器停止了,就不能再使用)
    [self wu_removeTimer];
}

/**
 *  停止拖拽的时候调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 开启定时器
    [self wu_addTimer];
}

- (void)wu_imagePressed:(UITapGestureRecognizer *)sender
{
    if ([self.delegate respondsToSelector:@selector(wu_scrollerViewDidClicked:activity:)]) {
        ZWActivity *activity = self.imageArray[sender.view.tag];
//        WuLog(@"%ld",sender.view.tag);
        [self.delegate wu_scrollerViewDidClicked:sender.view.tag activity:activity];
    }
}

@end
