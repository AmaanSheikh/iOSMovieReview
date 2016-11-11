//
//  SecondTableViewController.h
//  tmdbMovie
//
//  Created by Rafay on 11/8/16.
//  Copyright © 2016 AstuteSol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTableViewController.h"
#import "Connector.h"

@interface SecondTableViewController :UIViewController
{
    NSString *bio;
    NSString *actorProfilePath;
    NSNumber *actorID;
}

@property (strong,nonatomic)RootTableViewController *root;
@property (strong, nonatomic) IBOutlet UITableView *tableView2;
@property(strong,nonatomic)Connector *connectorClass;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelText;
@property (weak, nonatomic) IBOutlet UILabel *lblVote;
@property (weak, nonatomic) IBOutlet UILabel *lblDes;



@end
