//
//  SQLiteDatabase.swift
//  Tutorial5
//
//  Created by Lindsay Wells on 22/2/19.
//
//  You are welcome to use this class in your assignments, but you will need to modify it in order for
//  it to do anything!
//
//  Add your code to the end of this class for handling individual tables
//
//  Known issues: doesn't handle versioning and changing of table structure.
//

import Foundation
import SQLite3

class SQLiteDatabase
{
    /* This variable is of type OpaquePointer, which is effectively the same as a C pointer (recall the SQLite API is a C-library). The variable is declared as an optional, since it is possible that a database connection is not made successfully, and will be nil until such time as we create the connection.*/
    private var db: OpaquePointer?
    
    /* Change this value whenever you make a change to table structure.
        When a version change is detected, the updateDatabase() function is called,
        which in turn calls the createTables() function.
     
        WARNING: DOING THIS WILL WIPE YOUR DATA, unless you modify how updateDatabase() works.
     */
    private let DATABASE_VERSION = 15
    
    
    
    // Constructor, Initializes a new connection to the database
    /* This code checks for the existence of a file within the application’s document directory with the name <dbName>.sqlite. If the file doesn’t exist, it attempts to create it for us. Since our application has the ability to write into this directory, this should happen the first time that we run the application without fail (it can still possibly fail if the device is out of storage space).
     The remainder of the function checks to see if we are able to open a successful connection to this database file using the sqlite3_open() function. With all of the SQLite functions we will be using, we can check for success by checking for a return value of SQLITE_OK.
     */
    init(databaseName dbName:String)
    {
        //get a file handle somewhere on this device
        //(if it doesn't exist, this should create the file for us)
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("\(dbName).sqlite")
        
        //try and open the file path as a database
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK
        {
            print("Successfully opened connection to database at \(fileURL.path)")
            checkForUpgrade();
        }
        else
        {
            print("Unable to open database at \(fileURL.path)")
            printCurrentSQLErrorMessage(db)
        }
        
    }
    
    deinit
    {
        /* We should clean up our memory usage whenever the object is deinitialized, */
        sqlite3_close(db)
    }
    private func printCurrentSQLErrorMessage(_ db: OpaquePointer?)
    {
        let errorMessage = String.init(cString: sqlite3_errmsg(db))
        print("Error:\(errorMessage)")
    }
    
    private func createTables()
    {
        //INSERT YOUR createTable function calls here
        //e.g. createMovieTable()
        createRaffleTable()
        createPlayerTable()
    }
    private func dropTables()
    {
        //INSERT YOUR dropTable function calls here
        //e.g. dropTable(tableName:"Movie")
        dropTable(tableName:"raffle")
        dropTable(tableName:"player")
    }
    
    /* --------------------------------*/
    /* ----- VERSIONING FUNCTIONS -----*/
    /* --------------------------------*/
    func checkForUpgrade()
    {
        // get the current version number
        let defaults = UserDefaults.standard
        let lastSavedVersion = defaults.integer(forKey: "DATABASE_VERSION")
        
        // detect a version change
        if (DATABASE_VERSION > lastSavedVersion)
        {
            onUpdateDatabase(previousVersion:lastSavedVersion, newVersion: DATABASE_VERSION);
            
            // set the stored version number
            defaults.set(DATABASE_VERSION, forKey: "DATABASE_VERSION")
        }
    }
    
    func onUpdateDatabase(previousVersion : Int, newVersion : Int)
    {
        print("Detected Database Version Change (was:\(previousVersion), now:\(newVersion))")
        
        //handle the change (simple version)
        dropTables()
        createTables()
    }
    
    
    
    /* --------------------------------*/
    /* ------- HELPER FUNCTIONS -------*/
    /* --------------------------------*/
    
    /* Pass this function a CREATE sql string, and a table name, and it will create a table
        You should call this function from createTables()
     */
    private func createTableWithQuery(_ createTableQuery:String, tableName:String)
    {
        /*
         1.    sqlite3_prepare_v2()
         2.    sqlite3_step()
         3.    sqlite3_finalize()
         */
        //prepare the statement
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK
        {
            //execute the statement
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("\(tableName) table created.")
            }
            else
            {
                print("\(tableName) table could not be created.")
                printCurrentSQLErrorMessage(db)
            }
        }
        else
        {
            print("CREATE TABLE statement for \(tableName) could not be prepared.")
            printCurrentSQLErrorMessage(db)
        }
        
        //clean up
        sqlite3_finalize(createTableStatement)
        
    }
    /* Pass this function a table name.
        You should call this function from dropTables()
     */
    
    private func dropTable(tableName:String)
    {
        /*
         1.    sqlite3_prepare_v2()
         2.    sqlite3_step()
         3.    sqlite3_finalize()
         */
        
        //prepare the statement
        let query = "DROP TABLE IF EXISTS \(tableName)"
        var statement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, query, -1, &statement, nil)     == SQLITE_OK
        {
            //run the query
            if sqlite3_step(statement) == SQLITE_DONE {
                print("\(tableName) table deleted.")
            }
        }
        else
        {
            print("\(tableName) table could not be deleted.")
            printCurrentSQLErrorMessage(db)
        }
        
        //clear up
        sqlite3_finalize(statement)
    }
   
    func deleteRaffle(ID:Int32)
       {
           /*
            1.    sqlite3_prepare_v2()
            2.    sqlite3_step()
            3.    sqlite3_finalize()
            */
           
           //prepare the statement
           let query = "DELETE FROM raffle WHERE ID=\(ID)"
           var statement: OpaquePointer? = nil

           if sqlite3_prepare_v2(db, query, -1, &statement, nil)     == SQLITE_OK
           {
               //run the query
               if sqlite3_step(statement) == SQLITE_DONE {
                   print("\(ID) Raffle Delete.")
               }
           }
           else
           {
               print("\(ID) Raffle could not be deleted.")
               printCurrentSQLErrorMessage(db)
           }
           
           //clear up
           sqlite3_finalize(statement)
       }
    
    func deletePlayer(ID:Int32)
          {
              /*
               1.    sqlite3_prepare_v2()
               2.    sqlite3_step()
               3.    sqlite3_finalize()
               */
              
              //prepare the statement
              let query = "DELETE FROM player WHERE ID=\(ID)"
              var statement: OpaquePointer? = nil

              if sqlite3_prepare_v2(db, query, -1, &statement, nil)     == SQLITE_OK
              {
                  //run the query
                  if sqlite3_step(statement) == SQLITE_DONE {
                      print("Player with ID\(ID) is Deleted.")
                  }
              }
              else
              {
                  print("\(ID) player could not be deleted.")
                  printCurrentSQLErrorMessage(db)
              }
              
              //clear up
              sqlite3_finalize(statement)
          }
    
    //helper function for handling INSERT statements
    //provide it with a binding function for replacing the ?'s for setting values
    private func insertWithQuery(_ insertStatementQuery : String, bindingFunction:(_ insertStatement: OpaquePointer?)->())
    {
        /*
         Similar to the CREATE statement, the INSERT statement needs the following SQLite functions to be called (note the addition of the binding function calls):
         1.    sqlite3_prepare_v2()
         2.    sqlite3_bind_***()
         3.    sqlite3_step()
         4.    sqlite3_finalize()
         */
        // First, we prepare the statement, and check that this was successful. The result will be a C-
        // pointer to the statement:
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementQuery, -1, &insertStatement, nil) == SQLITE_OK
        {
            //handle bindings
            bindingFunction(insertStatement)
            
            /* Using the pointer to the statement, we can call the sqlite3_step() function. Again, we only
             step once. We check that this was successful */
            //execute the statement
            if sqlite3_step(insertStatement) == SQLITE_DONE
            {
                print("Successfully inserted row.")
            }
            else
            {
                print("Could not insert row.")
                printCurrentSQLErrorMessage(db)
            }
        }
        else
        {
            print("INSERT statement could not be prepared.")
            printCurrentSQLErrorMessage(db)
        }
    
        //clean up
        sqlite3_finalize(insertStatement)
    }
    
    
    //helper function to run Select statements
    //provide it with a function to do *something* with each returned row
    //(optionally) Provide it with a binding function for replacing the "?"'s in the WHERE clause
    private func selectWithQuery(
        _ selectStatementQuery : String,
        eachRow: (_ rowHandle: OpaquePointer?)->(),
        bindingFunction: ((_ rowHandle: OpaquePointer?)->())? = nil)
    {
        //prepare the statement
        var selectStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, selectStatementQuery, -1, &selectStatement, nil) == SQLITE_OK
        {
            //do bindings, only if we have a bindingFunction set
            //hint, to do selectMovieBy(id:) you will need to set a bindingFunction (if you don't hardcode the id)
            bindingFunction?(selectStatement)
            
            //iterate over the result
            while sqlite3_step(selectStatement) == SQLITE_ROW
            {
                eachRow(selectStatement);
            }
            
        }
        else
        {
            print("SELECT statement could not be prepared.")
            printCurrentSQLErrorMessage(db)
        }
        //clean up
        sqlite3_finalize(selectStatement)
    }
    
    //helper function to run update statements.
    //Provide it with a binding function for replacing the "?"'s in the WHERE clause
    private func updateWithQuery(
        _ updateStatementQuery : String,
        bindingFunction: ((_ rowHandle: OpaquePointer?)->()))
    {
        //prepare the statement
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementQuery, -1, &updateStatement, nil) == SQLITE_OK
        {
            //do bindings
            bindingFunction(updateStatement)
            
            //execute
            if sqlite3_step(updateStatement) == SQLITE_DONE
            {
                print("Successfully inserted row.")
            }
            else
            {
                print("Could not insert row.")
                printCurrentSQLErrorMessage(db)
            }
        }
        else
        {
            print("UPDATE statement could not be prepared.")
            printCurrentSQLErrorMessage(db)
        }
        //clean up
        sqlite3_finalize(updateStatement)
    }
    
    /* --------------------------------*/
    /* --- ADD YOUR TABLES ETC HERE ---*/
    /* --------------------------------*/
    //create Movie table function
    func createRaffleTable()
    {
        let createRaffleTableQuery =
        """
            CREATE TABLE raffle
            (
                ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                title CHAR(255),
                price INTEGER,
                max_ticket INTEGER,
                description CHAR(255),
                prize CHAR(255)
                
            );
        """
        createTableWithQuery(createRaffleTableQuery, tableName: "raffle")
    }
//    Create new raffle
    
    func insert(raffle: Raffle)
    {
        let insertStatementQuery =
            "INSERT INTO raffle (title, price, max_ticket, description, prize) VALUES (?, ?, ?, ?, ?);"
        
        insertWithQuery(insertStatementQuery, bindingFunction: { (insertStatement) in
            sqlite3_bind_text(insertStatement, 1, NSString(string:raffle.title).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 2, Int32(raffle.price))
            sqlite3_bind_int(insertStatement, 3, Int32(raffle.max_ticket))
            sqlite3_bind_text(insertStatement, 4, NSString(string:raffle.description).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, NSString(string:raffle.prize).utf8String, -1,
        nil) })
        
        
//        let newRaffleID = sqlite3_last_insert_rowid(db)
        //create related ticket table for the same raffle
        let createTicketTableQuery =
        """
        CREATE TABLE '\(raffle.title)'
            (
                ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                price INTEGER,
                playerName String,
                dateTime String
            );
        """
        createTableWithQuery(createTicketTableQuery, tableName:"\(raffle.title)")

    }
//
    
   


    
    
    // Query all Raffle
    func selectAllRaffle() -> [Raffle]
    {
        var result = [Raffle]()
        let selectStatementQuery = "SELECT ID,title,price,max_ticket,description,prize FROM raffle "
    
       selectWithQuery(selectStatementQuery, eachRow: { (row) in //create a movie object from each result
        let raffle = Raffle(
        ID: sqlite3_column_int(row, 0),
        title: String(cString:sqlite3_column_text(row, 1)),
        price: Int32(sqlite3_column_int(row, 2)),
        max_ticket: Int32(sqlite3_column_int(row, 3)),
        description: String(cString:sqlite3_column_text(row, 4)),
        prize: String(cString:sqlite3_column_text(row, 5))
        )
        //add it to the result array
        result += [raffle]
        })
        return result
    }
    
    // Query 1 movie
//    func selectMovieBy(id:Int32) -> Raffle?
//    {
//        var result : Raffle?
//        let selectStatementQuery = "SELECT id,name,year,director FROM Movie WHERE ID = \(id) "
//
//        selectWithQuery(selectStatementQuery, eachRow: { (row) in
//            //create a movie object from each result
//           let raffle = Raffle(
//               ID: sqlite3_column_int(row, 0),
//               name: String(cString:sqlite3_column_text(row, 1)),
//               year: sqlite3_column_int(row, 2),
//               director: String(cString:sqlite3_column_text(row, 3))
//           )
//           //add it to the result array
//           result = raffle
//           })
//           return result
//    }
    
    //create player table function
    func createPlayerTable()
       {
           let createPlayerTableQuery =
           """
               CREATE TABLE player
               (
                   ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                   fname CHAR(255),
                   contact_no INTEGER,
                   email CHAR(255)
                   
               );
           """
           createTableWithQuery(createPlayerTableQuery, tableName: "player")
       }
    
    //insert new player function
    func insertPlayer (player: Player)
    {
        let insertStatementQuery =
            "INSERT INTO player (fname, contact_no, email) VALUES (?, ?, ?);"
        
        insertWithQuery(insertStatementQuery, bindingFunction: { (insertStatement) in
            sqlite3_bind_text(insertStatement, 1, NSString(string:player.fname).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 2, player.contact_no)
           sqlite3_bind_text(insertStatement, 3, NSString(string:player.email).utf8String, -1, nil)
        })
    }
//select all players
    func selectAllPlayer() -> [Player]
       {
        var result = [Player]()
           let selectStatementQuery = "SELECT ID,fname,contact_no,email FROM player "
       
          selectWithQuery(selectStatementQuery, eachRow: { (row) in //create a player object from each result
           let player = Player(
           ID: sqlite3_column_int(row, 0),
           fname: String(cString:sqlite3_column_text(row, 1)),
           contact_no: sqlite3_column_int(row, 2),
           email: String(cString:sqlite3_column_text(row, 3))
           )
           //add it to the result array
           result += [player]
           })
        return result
       }
    //select one player
        func selectPlayerBy(name:String) -> Player?
        {
            var result : Player?
            let selectStatementQuery = "SELECT id,fname,contact_no,email FROM player WHERE fname = \(name) "
    
            selectWithQuery(selectStatementQuery, eachRow: { (row) in
                //create a movie object from each result
               let player = Player(
                   ID: sqlite3_column_int(row, 0),
                   fname: String(cString:sqlite3_column_text(row, 1)),
                   contact_no: sqlite3_column_int(row, 2),
                   email: String(cString:sqlite3_column_text(row, 3))
               )
               //add it to the result array
               result = player
               })
               return result
        }
    
    
// Mark:- Ticket related section

    func selectAllTicket(tableName:String) -> [Ticket]
    {
        var result = [Ticket]()
        let selectStatementQuery = "SELECT ID,price,playerName,dateTime From \(tableName)"
    
       selectWithQuery(selectStatementQuery, eachRow: { (row) in //create a movie object from each result
        let ticket = Ticket(
        ticketID: sqlite3_column_int(row, 0),
        tPrice: sqlite3_column_int(row, 1),
        playerName: String(cString:sqlite3_column_text(row, 2)),
        dateTime: String(cString:sqlite3_column_text(row, 3))
        )
        //add it to the result array
        result += [ticket]
        })
        return result
    }
//insert new ticket
    func insertTicket (raffleTitle:String, ticket: Ticket)
        {
            let insertStatementQuery =
                "INSERT INTO \(raffleTitle) (price,playerName, dateTime) VALUES (?, ?, ?);"
            
            insertWithQuery(insertStatementQuery, bindingFunction: { (insertStatement) in
                sqlite3_bind_int(insertStatement, 1, ticket.tPrice)
                sqlite3_bind_text(insertStatement, 2, NSString(string:ticket.playerName).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, NSString(string:ticket.dateTime).utf8String, -1, nil)
            })
        }
        
        
        
        
        
    
    
    
    
}
