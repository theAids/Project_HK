﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project_HK.Models;
using System.Data.SqlClient;
using System.Xml;
using System.Diagnostics;
using System.Configuration;
using System.Web.Configuration;
using System.IO;
using System.Text;
using System.Web.Security;
using Project_HK.Models.DbManager;

namespace Project_HK.Control_Panel
{
    public partial class Db_Extract : System.Web.UI.Page
    {
        private List<ConnectionModel> connStrings = new List<ConnectionModel>();
        private string user;
        private string role;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
            {
                Response.Redirect("~/Accounts/Login.aspx", true);
            }
            else
            {
                // get cookies
                FormsIdentity id = HttpContext.Current.User.Identity as FormsIdentity;
                FormsAuthenticationTicket ticket = id.Ticket;

                // access logged in name Literal in Master page
                Literal currentUser = this.Master.FindControl("currentUser") as Literal;
                user = currentUser.Text = ticket.UserData.Split('|')[0];
                role = ticket.UserData.Split('|')[1];
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {                // populate db panel
                connStrings = DbConnManager.GetConnectionStrings();
                this.db_connection.DataSource = connStrings;
                this.db_connection.DataBind();
            }

            //check if admin
            if (role.Equals("Administrator"))
                adminMenu.Controls.Add(new LiteralControl("<li><a href='../Admin/UserAdmin.aspx'><span class='glyphicon glyphicon-user icon'></span>User Admin</a></li>"));
        }

        protected void extractXML(object sender, CommandEventArgs e)
        {

            DateTime datetime = DateTime.UtcNow;

            // get connection string name based from clicked LinkButton
            ConnectionModel conn = DbConnManager.GetConnectionStrings().Find(cs => cs.name == e.CommandArgument.ToString());

            // create directory if not exists
            Directory.CreateDirectory(Server.MapPath("~/logs"));

            string xmlpath = Server.MapPath("~/logs") + "\\{0} {1}.xml";
            xmlpath = string.Format(xmlpath, datetime.ToString("yyyy-MM-dd HHmmss", System.Globalization.CultureInfo.InvariantCulture), conn.dbname);

            XmlDocument xmldoc = null;

            // execute corresponding actions for each db connection strings
            switch (e.CommandArgument.ToString())
            {
                case "PeopleConnection":
                    xmldoc = DatabaseManager.ExtractPeopleData();
                    break;
                case "TimeConnection":
                    xmldoc = DatabaseManager.ExtractTimeData();
                    break;
            }

            //export xml into external file
            //File.AppendAllText(xmlpath, xmldoc.OuterXml);

            LogAction(conn, xmldoc.OuterXml);
        }

        protected void ClearLog(object sender, EventArgs e)
        {
            logPanel.Text = "";
        }

        protected void LogAction(ConnectionModel conn, string xml)
        {
            DateTime datetime = DateTime.UtcNow;

            // creating log entries
            string path = Server.MapPath("~/logs") + "\\{0}.log";
            path = string.Format(path, datetime.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture));
            
            StringBuilder sb = new StringBuilder();

            sb.Append(string.Format("[{0} {1}]\nUser: {2}\nDatabase: {3}\nServer: {4}\nExtracted XML:\n{5}\n", datetime.ToString("yyyy-mm-dd HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture)
                                                    , TimeZoneInfo.Local.ToString()
                                                    , user
                                                    , conn.dbname
                                                    , conn.servername
                                                    , xml));

            logPanel.Text = System.Security.SecurityElement.Escape(sb.ToString()).Replace("\n", "<br>") + logPanel.Text;

            // export log into external file. log file is created for each day.
            File.AppendAllText(path, sb.ToString().Replace("\n", Environment.NewLine));

        }
    }
}