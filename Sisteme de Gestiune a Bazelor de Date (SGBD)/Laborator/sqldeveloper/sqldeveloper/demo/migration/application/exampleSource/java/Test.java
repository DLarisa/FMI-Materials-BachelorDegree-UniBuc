package oracle.dbtools.raptor.migration.applications.rules.samples.exampleSource;
import java.sql.Connection;
import java.sql.DriverManager;
class Test {
public static void main(String[] args) {
try {
    Class.forName("com.sybase.jdbc.SybDriver");// for sybase driver
} catch(ClassNotFoundException e) {
    System.err.println("Error loading driver: " + e);
}
//for sybase driver
  String host = "dbhost.yourcompany.com";
  String dbName = "someName";
  int port = 1234;  
  String sybaseURL = "jdbc:sybase:Tds:" + host +
  ":" + port + ":" + "?SERVICENAME=" + dbName;
}
}
