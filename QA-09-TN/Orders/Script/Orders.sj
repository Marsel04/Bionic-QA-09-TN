
function Main()
{
  try
  {
    RunOrders();
    TestOrderCreation();
    TestOrderEdit();
    DeleteOrders();
    Exit();
  }
  catch(exception)
  {
    Log.Error("Exception", exception.description);
  }
}

// runs the program
function RunOrders()
{
  Log.AppendFolder("Run");
  TestedApps.Orders.Run();
  Log.PopLogFolder();
}          

// creates orders from file and checks customer names for all orders
function TestOrderCreation()
{
  Log.AppendFolder("OrderCreation");  
  
  var  orders = Aliases.Orders;
  var index = 0;
  //read from file
  var driver = DDT.CSVDriver(Files.FileNameByName("CustomerNames.txt")); 
  
  while (!driver.EOF()) 
  {
    Indicator.PushText("Read from file");
    Delay(1000, Indicator.Text);
  
    var customerName = driver.Value(0); 
    var customerStreet = driver.Value(1);  
    var customerState = driver.Value(2);  
    var customerCity = driver.Value(3);  
    var customerZipCode = driver.Value(4);  
    var customerCardNo = driver.Value(5); 
    
    CreateNewOrder(orders, customerName, customerStreet, customerState, customerCity, customerZipCode, customerCardNo);  
    CheckCustomerName(orders, index, customerName);
    
    index++; 
    driver.Next();
  }
  DDT.CloseDriver("driver"); 
  Log.PopLogFolder(); 
}

//checks customer name for an order
function CheckCustomerName(orders, index, customerName)
{
  orders.MainForm.OrdersView.SelectItem(index);
  
  Indicator.PushText("Check customer name value");
  Delay(1000, Indicator.Text);
  
  if(orders.MainForm.OrdersView.FocusedItem.Text.OleValue != customerName)
    Log.Error("The property value does not equal the baseline value.");
  else
    Log.Message("OK"); 
}

// creates new order
function CreateNewOrder(orders, customerName, customerStreet, customerState, customerCity, customerZipCode, customerCardNo)
{
  var  orderForm;
  var  groupBox;
  var  textBox;
  
  Indicator.PushText("Create order"); 
  Delay(1000, Indicator.Text);  
  
  orders.MainForm.MainMenu.Click("Orders|New order...");
  orderForm = orders.OrderForm;
  groupBox = orderForm.Group;
  textBox = groupBox.Customer;
  textBox.Click(27, 10);
  textBox.wText = customerName;
  textBox = groupBox.Street;
  textBox.Click(23, 11);
  textBox.wText = customerStreet;
  textBox = groupBox.State;
  textBox.Click(24, 4);
  textBox.wText = customerState;
  textBox = groupBox.City;
  textBox.Click(21, 6);
  textBox.wText = customerCity;
  textBox = groupBox.Zip;
  textBox.Click(21, 17);
  textBox.wText = customerZipCode;
  textBox = groupBox.CardNo;
  textBox.Click(28, 8);
  textBox.wText = customerCardNo;
  orderForm.ButtonOK.ClickButton();
}   

// check customer name after order was edited
function TestOrderEdit()
{
  Log.AppendFolder("OrderEdit");  
  var  orders = Aliases.Orders;
  var customerName;
  var newCustomerName;
  
  //steps to reproduce
  for (i=0;i<=4;i++)  //5 - quantity of rows
{
  orders.MainForm.OrdersView.SelectItem(i);
  customerName = orders.MainForm.OrdersView.FocusedItem.Text.OleValue;
  newCustomerName = customerName + i;
  EditOrder(orders, newCustomerName);  
  // check customer name
  if(orders.MainForm.OrdersView.FocusedItem.Text.OleValue != newCustomerName)
  Log.Error("The property value does not equal the baseline value.");
  else
  Log.Message("OK"); 
}
  Log.PopLogFolder(); 
}

//editing of selected order
function EditOrder(orders, newCustomerName)
{
  var  mainForm;
  var  orderForm;
  var  textBox;
  mainForm = orders.MainForm;
  mainForm.MainMenu.Click("Orders|Edit order...");
  orderForm = orders.OrderForm;
  textBox = orderForm.Group.Customer;
  textBox.wText = newCustomerName;
  orderForm.ButtonOK.ClickButton();
}


// deletes all orders  
function DeleteOrders()
{
  Log.AppendFolder("DeleteOrders");  
  var  orders;
  orders = Aliases.Orders;
  
  Indicator.PushText("Delete orders"); 
  Delay(1000, Indicator.Text);  
       
  for (i=0;i<=4;i++)
{       
  orders.MainForm.OrdersView.SelectItem(0);
  orders.MainForm.OrdersView.FocusedItem.Remove();
}
  Log.PopLogFolder(); 
}


// exits the program    
function Exit()
{
  Log.AppendFolder("Exit");  
  var  orders;
  orders = Aliases.Orders;
  orders.MainForm.Close();
  orders.dlgConfirmation.btnNo.ClickButton();
  Log.PopLogFolder();  
}
