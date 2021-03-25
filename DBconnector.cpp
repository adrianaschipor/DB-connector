#include <stdlib.h>
#include <iostream>
#include<string>
#include "mysql_connection.h"

#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>
#include <cppconn/prepared_statement.h>

using namespace std;

class DatabaseManager{
    string m_server{"tcp://127.0.0.1:3306"};
    string m_user;
    string m_password;
    string m_database;
    
    sql::Driver *m_driver;
    sql::Connection *m_con;
    sql::Statement *m_stmt;
    sql::PreparedStatement *m_pstmt;
    sql::ResultSet *m_res;
public:
    /*DatabaseManager(string user, string password, string database, string server="tcp://127.0.0.1:3306") : m_user{user}, m_password{password}, m_database{database}, m_server{server} {}*/
    DatabaseManager(string user, string password, string database) : m_user{user}, m_password{password}, m_database{database}
    {
        m_driver = get_driver_instance();
        m_con= m_driver->connect(m_server, m_user, m_password);
        m_con->setSchema(m_database);
    }
    
    DatabaseManager(string server, string user, string password, string database) : m_server{server}, m_user{user}, m_password{password}, m_database{database} 
    {
        m_driver = get_driver_instance();
        m_con= m_driver->connect(m_server, m_user, m_password);
        m_con->setSchema(m_database);
    }    

    ~DatabaseManager()
    {
        delete m_res;
        delete m_stmt;
        delete m_pstmt;
        delete m_con;  
    }
    
    sql::Connection * getConnection()
    {
        return m_con;
    }
    
    void execute(string query) //for DDL Commands (eg:execute, alter, drop, truncate)
    {
        m_stmt = m_con->createStatement();
        m_stmt->execute(query);
    }
    
    sql::ResultSet * executeQuery (string query) //for statements that return tabular data
    {
         m_stmt = m_con->createStatement();
         m_res = m_stmt->executeQuery(query);
         return m_res;
    }
    
    void executeUpdate(string query, int value)
    {
        m_pstmt = m_con->prepareStatement(query);
        m_pstmt->setInt(1, value);
        m_pstmt->executeUpdate();    
    }
    void executeUpdate(string query, string value)
    {
        m_pstmt = m_con->prepareStatement(query);
        m_pstmt->setString(1, value);
        m_pstmt->executeUpdate();    
    }
};

int main(void)
{
 cout << endl;

try {
  sql::ResultSet *res;
  
  DatabaseManager db("admin", "adriana", "test");
  
  //Display all customers names
  cout<<"CUSTOMERS:"<<endl;
  res = db.executeQuery("SELECT * FROM Customers;");
  while(res->next())
  {
     cout<<res->getString("LastName")<<" "<<res->getString("FirstName")<<endl;
  }
  
  //update an item's price
  cout<<"\nInitial price: ";
  res = db.executeQuery("SELECT ItemID, price AS initial_price FROM Items WHERE ItemID=1;");
  res->next();
  cout<<res->getInt("initial_price")<<endl;
  db.executeUpdate("UPDATE Items SET price = ? WHERE ItemId=1;", 30);
  cout<<"Final price: ";
  res = db.executeQuery("SELECT ItemID, price AS final_price FROM Items WHERE ItemID=1;");
  res->next();
  cout<<res->getInt("final_price")<<endl;
  
  //update an item's brand
  cout<<"\nInitial brand: ";
  res = db.executeQuery("SELECT brand FROM Items WHERE ItemID=1;");
  res->next();
  cout<<res->getString("brand")<<endl;
  db.executeUpdate("UPDATE Items SET brand = ? WHERE ItemId=1;", "nike");
  cout<<"Updated brand: ";
  res = db.executeQuery("SELECT brand FROM Items WHERE ItemID=1;");
  res->next();
  cout<<res->getString("brand")<<endl;
  
} catch (sql::SQLException &e) {
  cout << "# ERR: SQLException in " << __FILE__;
  cout << "(" << __FUNCTION__ << ") on line "
     << __LINE__ << endl;
  cout << "# ERR: " << e.what();
  cout << " (MySQL error code: " << e.getErrorCode();
  cout << ", SQLState: " << e.getSQLState() << " )" << endl;
}

cout << endl;

return EXIT_SUCCESS;
}
