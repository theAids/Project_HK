﻿using Project_HK.Models.DbManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace Project_HK
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            AccountManager.CreateAccountsTable();
            //Default user, comment if necessary
            AccountManager.AddUser("admin", "admin", "user", "admin123", "Administrator");
        }
    }
}