//
//  ExpandTableModel.h
//  ExpandTable
//
//  Created by Guangyu Zhang on 4/10/13.
//  Copyright (c) 2013 Guangyu Zhang(come2u@gmail.com). All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IExpandItem 
@property(nonatomic,strong)NSArray *ETMChildren;
@property(nonatomic,assign)BOOL ETMExpanded;
@property(nonatomic,assign)id<IExpandItem> ETMParent;
@end


@interface ExpandTableModel : NSObject{
}

//root level items list
@property(nonatomic,strong)NSArray *rootItems;


//index in rootItems of the current expand item
@property(nonatomic,assign)int expandItemIndex;


- (id<IExpandItem>)itemAtRow:(int)row;

//current ETMExpandedItem, readonly
- (id<IExpandItem>)expandedItem;

- (int)numOfRows;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface ExpandItem : NSObject<IExpandItem>
@property(nonatomic,strong)NSString *title;

+(id)modelWithString:(NSString *)string ETMChildrentr:(NSArray *)children;

@end