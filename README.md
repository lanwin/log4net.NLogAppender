log4net.NLogAppender
=============================
This is a bridge between NLog and log4net. It hands all log4net logging over to
NLog. So you could use any lib which uses log4net without even using log4net 
yourself.

Simply call the following line and you are done:

   NLogAppender.Initialize();
   
##Get it
You can grab it via NuGet with searching for '''log4net.NLogAppender'''

## Contributors
* Lanwin