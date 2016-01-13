//
//  ZWThirdClassViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/7.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWGoodDetailsClassViewController.h"
#import "ZWPlainFlowLayout.h"
#import "ZWCommodityDetailsViewController.h"
#import "ZWGoodDetailsCell.h"
#import "ZWGoodDetailsItems.h"
#import "ZWCommodityDetailsHttpTool.h"
#import "ZWCommodityParams.h"
#import "ZWBrandDetailsItems.h"
#import "ZWSearchShopResualt.h"
#import "ZWSearchShopParams.h"
#import "ZWHomeHttpTool.h"
#import "ZWActivityGoodsDetailItem.h"

@interface ZWGoodDetailsClassViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSArray *goodDetailArray;
@property(nonatomic,strong)ZWBrandDetailsItems *brandDetailsItems;
@property(nonatomic,strong)ZWSearchShopResualt *searchShopResualt;
@property(nonatomic,weak)MBProgressHUD *HUD;
@property(nonatomic,weak)UICollectionView *colleView;

@property(nonatomic,weak)UIImageView *titleImegeView;

@end

@implementation ZWGoodDetailsClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    HUD.dimBackground = YES;
    self.HUD = HUD;
    
//    [self wu_creatView];
    
    [self wu_switchParams];
}

- (void) wu_switchParams
{
    if (_classRequestPrams) {
        [self wu_creatViewWithCollectionViewFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) flowLayoutNaviHeight:64];
        [self wu_getClassification];
    }
    else if (_brandRequestParams)
    {
        [self wu_creatViewWithCollectionViewFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) flowLayoutNaviHeight:64];
        [self wu_getBrandList];
    }
    else if (_searchShopParams)
    {
        [self wu_creatViewWithCollectionViewFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) flowLayoutNaviHeight:64];
        [self wu_searchShopResualt];
    }
    else if (_activityParams)
    {
        [self wu_getActivityDetail];
    }
}

- (void)wu_getActivityDetail
{
    __weak typeof(self)myself = self;
    [ZWHomeHttpTool wu_getActivityParams:_activityParams success:^(ZWActivityGoodsDetailItem *activityGoodsDetailItem) {
        WuLog(@"%@",activityGoodsDetailItem);
        myself.HUD.hidden = YES;
        CGFloat titleImegeViewH = 0;
        Screen_Height <= 568 ? (titleImegeViewH = 100) : (titleImegeViewH = 150);
        UIImageView *titleImegeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, titleImegeViewH)];
        myself.titleImegeView = titleImegeView;
        [myself.view addSubview:titleImegeView];
        [myself.titleImegeView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", httpResourcesAddress, activityGoodsDetailItem.imgUrl]] placeholderImage:[UIImage imageNamed:@"huo_jiushui"]];
        [myself wu_creatViewWithCollectionViewFrame:CGRectMake(0, myself.titleImegeView.frame.origin.y + myself.titleImegeView.frame.size.height, Screen_Width, Screen_Height - myself.titleImegeView.frame.size.height - myself.titleImegeView.frame.origin.y) flowLayoutNaviHeight:0];
        myself.goodDetailArray = activityGoodsDetailItem.itemList;
        [myself.colleView reloadData];
    } failure:^(NSError *error) {
        myself.HUD.hidden = YES;
        [MBProgressHUD showError:@"网络出错"];
    }];
}

- (void)wu_searchShopResualt
{    
    __weak typeof(self)myself = self;
    [ZWCommodityDetailsHttpTool wu_getSearchGoodsListWithParams:_searchShopParams success:^(ZWSearchShopResualt *searchShopResualt) {
        WuLog(@"%@",searchShopResualt);
        myself.HUD.hidden = YES;
        self.searchShopResualt = searchShopResualt;
        myself.goodDetailArray = searchShopResualt.itemList;
        [myself.colleView reloadData];
    } failure:^(NSError *error) {
        myself.HUD.hidden = YES;
        [MBProgressHUD showError:@"网络出错"];
    }];
}

- (void) wu_getBrandList
{
    __weak typeof(self)myself = self;
    [ZWCommodityDetailsHttpTool wu_getBrandListWithParams:_brandRequestParams success:^(ZWBrandDetailsItems *brandDetailsItems) {
        WuLog(@"%@",brandDetailsItems);
        myself.HUD.hidden = YES;
        self.brandDetailsItems = brandDetailsItems;
        myself.goodDetailArray = brandDetailsItems.itemList;
        [myself.colleView reloadData];
    } failure:^(NSError *error) {
        myself.HUD.hidden = YES;
        [MBProgressHUD showError:@"网络出错"];
    }];
}

- (void) wu_getClassification
{
    __weak typeof(self)myself = self;
    [ZWCommodityDetailsHttpTool wu_getClassificationWithParams:_classRequestPrams success:^(NSArray *array) {
        WuLog(@"%@",array);
        myself.HUD.hidden = YES;
        myself.goodDetailArray = array;
        [myself.colleView reloadData];
    } failure:^(NSError *error) {
        myself.HUD.hidden = YES;
        [MBProgressHUD showError:@"网络出错"];
    }];
}

- (void)dealloc
{
    WuLog(@"dealloc");
}

- (void)wu_creatViewWithCollectionViewFrame:(CGRect)frame flowLayoutNaviHeight:(CGFloat)naviHeight
{
    ZWPlainFlowLayout *flowLayout = [[ZWPlainFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(Screen_Width, 35);
    flowLayout.naviHeight = naviHeight;
    
//    UIImageView *titleImegeView = [[UIImageView alloc] init];
//    self.titleImegeView = titleImegeView;
//    [self.view addSubview:titleImegeView];
    
    UICollectionView *colleView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    colleView.backgroundColor = [UIColor clearColor];
    colleView.delegate = self;
    colleView.dataSource = self;
    self.colleView = colleView;
    [self.view addSubview:colleView];
    
    [colleView registerClass:[ZWGoodDetailsCell class] forCellWithReuseIdentifier:@"GradientCell"];
    [colleView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerIdentifier"];
}

- (NSArray *)goodDetailArray
{
    if (_goodDetailArray == nil) {
        _goodDetailArray = [NSArray array];
    }
    return _goodDetailArray;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodDetailArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GradientCell";
    ZWGoodDetailsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    ZWGoodDetailsItems *items = self.goodDetailArray[indexPath.row];
    cell.collectionItem = items;
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *phoneModel = [[UIDevice currentDevice] model];
//    NSLog(@"phoneModel---%f", [UIScreen mainScreen].bounds.size.width);
//    [UIScreen mainScreen].bounds.size.width
//    return CGSizeMake(Screen_Width * 0.47, Screen_Width * 0.5);  // 6/6Plus
    CGFloat collectionViewW = 0;
    
    Screen_Width <= 320.0 ? (collectionViewW = Screen_Width * 0.48) : (collectionViewW = Screen_Width * 0.48);
    
    return CGSizeMake(collectionViewW, Screen_Width * 0.5);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
//    return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    return UIEdgeInsetsMake(0, 1, 5, 1);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
    WuLog(@"%@-indexPath",indexPath);
    ZWCommodityDetailsViewController *commodityDetailsViewController = [[ZWCommodityDetailsViewController alloc] init];
    commodityDetailsViewController.title = @"商品详情";
    ZWCommodityParams *params = [[ZWCommodityParams alloc] init];
    ZWGoodDetailsItems *items = self.goodDetailArray[indexPath.row];
    params.commodityID = items.classID;
    params.rows = @(3);
    commodityDetailsViewController.commodityParams = params;
    [self.navigationController pushViewController:commodityDetailsViewController animated:YES];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
//    (kind == UICollectionElementKindSectionHeader)
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerIdentifier" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    CGFloat buttonY = 5;
    CGFloat padding = 50;
    CGFloat buttonW = (Screen_Width - padding * 4) / 3;
    CGFloat buttonH = 25;
    for (int i = 0; i < 3; i ++) {
        CGFloat buttonX = padding + (padding + buttonW) * i;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
//        button.backgroundColor = [UIColor redColor];
        NSString *btnName = nil;
        switch (i) {
            case 0:
                btnName = @"价格";
                break;
            case 1:
                btnName = @"销量";
                break;
            case 2:
                btnName = @"新品";
                break;
            default:
                break;
        }
        [button setTitle:btnName forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(wu_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:button];
    }
    return headerView;
}

- (void)wu_buttonClick:(UIButton *)button
{
    WuLog(@"buttonClick");
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
