function Main()
{
  try
  {
    Sum();
    Mult(); 
  }
  catch(exception)
  {
    Log.Error("Exception", exception.description);
  }
}

function Sum()
{
  TestedApps.calc.Run();
  Aliases.calc.wndCalculator.btn2.ClickButton();
  Aliases.calc.wndCalculator.btn.ClickButton();
  Aliases.calc.wndCalculator.btn2.ClickButton();
  Aliases.calc.wndCalculator.btn1.ClickButton();
  aqObject.CompareProperty(Aliases.calc.wndCalculator.Edit.wText, 0, "3.", false);
  Aliases.calc.wndCalculator.Close();
}


function Mult()
{
  var  wndCalculator;
  var  btn4;
  TestedApps.calc.Run();
  wndCalculator = Aliases.calc.wndCalculator;
  wndCalculator.btn3.ClickButton();
  wndCalculator.btn4.ClickButton();
  btn4 = wndCalculator.btn41;
  btn4.ClickButton();
  btn4.ClickButton();
  wndCalculator.btn1.ClickButton();
  aqObject.CompareProperty(Aliases.calc.wndCalculator.Edit.wText, cmpEqual, "132. ", false);
  wndCalculator.Close();
}
