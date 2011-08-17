using System;
using NLog.Config;
using log4net;
using LogManager = NLog.LogManager;

namespace Sample
{
    class Program
    {
        static void Main()
        {
            SimpleConfigurator.ConfigureForConsoleLogging();

            LogManager.GetLogger("app").Info("works");

            NLogAppender.Initialize();

            LogWithLog4Net();

            Console.ReadLine();
        }

        static void LogWithLog4Net()
        {
            var log = log4net.LogManager.GetLogger("foobar");
            log.Info("foobar");
            log.Info("foobar");
            log.Info("foobar");
            log.Info("foobar");
            log.Info("foobar");
            log.Info("foobar");
            log.Info("foobar");
            log.Info("foobar");
            log.Info("foobar");
            log.Info("foobar");
            log.Info("foobar");
            log.Info("foobar");
            log.Info("foobar");
        }
    }
}