//
//  MyTableViewController.m
//  ToDoCoreData
//
//  Created by Jayesh Wadhwani on 2016-05-25.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//

#import "MyTableViewController.h"
#import "AppDelegate.h"
#import "Todo.h"


@interface MyTableViewController ()<NSFetchedResultsControllerDelegate>



@property (strong, nonatomic) NSFetchedResultsController *fetchedController;
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (weak, nonatomic) IBOutlet UITextField *text1;
@property (weak, nonatomic) IBOutlet UITextField *text2;

@end

@implementation MyTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view setBackgroundColor:[UIColor clearColor]];

    AppDelegate *appDel = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = appDel.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Todo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    //    request.predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@", @"foo"];
    
    //    NSArray* foods = [moc executeFetchRequest:request error:nil];
    
    self.fetchedController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil];
    self.fetchedController.delegate = self;
    [self.fetchedController performFetch:nil];
    
    




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.fetchedController fetchedObjects] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
     [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detail" sender:self];


}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addAction:(id)sender {
    NSManagedObjectContext *moc = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    
NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    Todo *newTodo = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:moc];
    if ([self.text1 hasText]) {
        newTodo.title = self.text1.text;

    }else
        newTodo.title = [prefs
                         stringForKey:@"defaulttitle"];
    
    if ([self.text2 hasText]) {
        newTodo.descript = self.text2.text;
        
    }else
        newTodo.descript = [prefs
                         stringForKey:@"defauldescript"];


   
    
    [moc save:nil];
    self.text1.text = @"";
    self.text2.text = @"";
    
}

- (IBAction)addActionDefault:(id)sender {

    [self performSegueWithIdentifier:@"default" sender:self];


}

- (IBAction)actionONLogout:(id)sender {

[self.navigationController popToRootViewControllerAnimated:YES];

}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Todo *todo;
    NSManagedObjectContext *moc = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
            todo = [self.fetchedController objectAtIndexPath:indexPath];
            [moc deleteObject:todo];
            [moc save:nil];
            break;
            
        default:
            break;
    }
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.mytable beginUpdates];}

//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
//           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
//    
//    switch(type) {
//        case NSFetchedResultsChangeInsert:
//            [self.mytable insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
//                                withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [self.mytable deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
//                                withRowAnimation:UITableViewRowAnimationFade];
//            break;
//        default:
//            break;
//    }
//}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.mytable;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.mytable endUpdates];
}

- (void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    Todo *todo = [self.fetchedController objectAtIndexPath:indexPath];
    UILabel *label = [cell viewWithTag:1];
    label.text= [NSString stringWithFormat:@" title :%@   desc :%@ " , todo.title, todo.descript];
}


@end
