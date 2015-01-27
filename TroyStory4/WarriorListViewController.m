//
//  ViewController.m
//  TroyStory4
//
//  Created by Syed Amaanullah on 1/27/15.
//  Copyright (c) 2015 Syed Amaanullah. All rights reserved.
//

#import "WarriorListViewController.h"
#import <CoreData/CoreData.h> 
#import "AppDelegate.h"
#import "Warrior.h"

@interface WarriorListViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSManagedObjectContext *moc;
@property (nonatomic) NSArray *warriors;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation WarriorListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appDelegate.managedObjectContext;

    [self loadWarriors];
}

- (IBAction)onAddWarrior:(UITextField *)sender {
    [sender resignFirstResponder];

    Warrior *warrior = [NSEntityDescription insertNewObjectForEntityForName:@"Warrior" inManagedObjectContext:self.moc];
    warrior.name = sender.text;
    warrior.prowess = [NSNumber numberWithInt:arc4random_uniform(100) + 1];

    [self.moc save:nil];
    [self loadWarriors];
    sender.text =nil;
}

-(void)loadWarriors {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Warrior"];
    NSSortDescriptor *prowessSorter = [[NSSortDescriptor alloc] initWithKey:@"prowess" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:prowessSorter];
    request.predicate = [NSPredicate predicateWithFormat:@"prowess > 40"];
    self.warriors = [self.moc executeFetchRequest:request error:nil];
}

-(void)setWarriors:(NSArray *)warriors {
    _warriors = warriors;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.warriors.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    Warrior *warrior = [self.warriors objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = warrior.name;
    cell.detailTextLabel.text = warrior.prowess.stringValue;
    return cell;
}


@end
