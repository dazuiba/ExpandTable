//
//  ViewController.m
//  ExpandTable
//
//  Created by Guangyu Zhang on 4/10/13.
//  Copyright (c) 2013 Guangyu Zhang. All rights reserved.
//

#import "ViewController.h"
@interface ViewController (){
    ExpandTableModel *_expandModel;
}

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [ExpandItem modelWithString:@"A" ETMChildrentr:@[@"A1",@"A2"]],
                      [ExpandItem modelWithString:@"B" ETMChildrentr:@[@"B1",@"B2"]],
                      [ExpandItem modelWithString:@"C" ETMChildrentr:@[@"C1",@"C2",@"C3",@"C4",@"C5",@"C6"]],
                      [ExpandItem modelWithString:@"E" ETMChildrentr:@[@"E1"]],
                      
                      nil];
    
    _expandModel = [[ExpandTableModel alloc] init];
    _expandModel.rootItems = array;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _expandModel.numOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    ExpandItem *item = (ExpandItem *)[_expandModel itemAtRow:indexPath.row];
    if (item.ETMParent) {
        cell.contentView.backgroundColor = [UIColor grayColor];
        cell.backgroundColor = [UIColor grayColor];
        cell.textLabel.backgroundColor = [UIColor grayColor];
    }else{
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    cell.textLabel.text = item.title;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_expandModel tableView:tableView didSelectRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
