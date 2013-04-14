//
//  TestExpandTableViewController.m
//  hzbus
//
//  Created by Guangyu Zhang(come2u@gmail.com) on 4/10/13.
//
//

#import "ExpandTableModel.h"

@implementation ExpandItem
@synthesize ETMChildren,ETMExpanded,ETMParent;

+(id)modelWithString:(NSString *)string ETMChildrentr:(NSArray *)children{
    ExpandItem *result = [[ExpandItem alloc] init];
    result.title = string;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:children.count];
    for (NSString *childStr in children) {
        ExpandItem *model = [[ExpandItem alloc] init];
        model.title = childStr;
        model.ETMParent = result;
        [array addObject:model];
    }
    result.ETMChildren = array;
    return result;
}
@end


@implementation ExpandTableModel
@synthesize expandItemIndex = _expandItemIndex;

- (id)init
{
    self = [super init];
    if (self) {
        _expandItemIndex = -1;
    }
    return self;
}

- (void)collapse{
    self.expandItemIndex = -1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id<IExpandItem> item = [self itemAtRow:indexPath.row];
    int indexShouldExpand = NSNotFound;
    if (!item.ETMParent) {
        indexShouldExpand = [self.rootItems indexOfObject:item];
    }
    NSArray *deleteIndexes = [self expandedIndexes];
    [self collapse];
    [tableView deleteRowsAtIndexPaths:deleteIndexes withRowAnimation:UITableViewRowAnimationAutomatic];
    if( indexShouldExpand !=NSNotFound){
        self.expandItemIndex = indexShouldExpand;
        NSArray *insertIndexes = [self expandedIndexes];
        NSLog(@"expand: %@",insertIndexes);
        [tableView insertRowsAtIndexPaths:insertIndexes withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    

}


- (void)setExpandItemIndex:(int)expandItemIndex{
    if (_expandItemIndex!=expandItemIndex) {
        if (_expandItemIndex >= 0) {
            ExpandItem *item = self.rootItems[_expandItemIndex];
            item.ETMExpanded = NO;
        }
        if (expandItemIndex >= 0) {
            ExpandItem *item = self.rootItems[expandItemIndex];
            item.ETMExpanded = YES;
        }
        NSLog(@"----------old:%d, new: %d",_expandItemIndex,expandItemIndex);
        _expandItemIndex = expandItemIndex;
    }
}

- (NSArray *)expandedIndexes{
    NSMutableArray *array = [NSMutableArray array];
    if (self.expandedItem) {
        for (int i = 0 ; i < self.expandedItem.ETMChildren.count; i++) {
            [array addObject:[NSIndexPath indexPathForRow:self.expandItemIndex+1+i inSection:0]];
        }
    }
    return array;
}

- (ExpandItem *)expandedItem{
    if (_expandItemIndex<0) {
        return nil;
    }
    return self.rootItems[_expandItemIndex];
}

- (ExpandItem *)itemAtRow:(int)row{
    if (_expandItemIndex<0) {
        assert(row>=0 && row < self.rootItems.count);
        return self.rootItems[row];
    }
    
    if (row <= _expandItemIndex) {
        assert(row>=0 && row < self.rootItems.count);
        return self.rootItems[row];
    }
    
    if (row <= _expandItemIndex + self.expandedItem.ETMChildren.count) {
        int index = row - _expandItemIndex - 1;
        assert(index>=0 && index<self.expandedItem.ETMChildren.count);
        ExpandItem *item = self.expandedItem.ETMChildren[index];
        NSLog(@"expandIndex: %d, row: %d, index, %d, item: %@",_expandItemIndex, row,index,item.title);
        return item;
    }
    
    row = row - self.expandedItem.ETMChildren.count;
    assert(row >=0 && row < self.rootItems.count);
    return self.rootItems[row];
}

- (int)numOfRows{
    int count = self.rootItems.count;
    for (ExpandItem *item in self.rootItems) {
        if (item.ETMExpanded) {
            count+=item.ETMChildren.count;
        }
    }
    return count;
}

@end