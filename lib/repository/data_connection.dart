mixin Connection
{

}

class DataConnection
{
  static String ipAdress;
  static String token; //it's a timeout
  static String tenant;
  static String username;
  static String password;

  DataConnection._default();

  factory DataConnection(this.ipAdress,ip)
}