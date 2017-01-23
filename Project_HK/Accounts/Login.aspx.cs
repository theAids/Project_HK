using Project_HK.Models.DbManager;
using Project_HK.Models.EntityModels;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_HK.Accounts
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void loginbtn_Click(object sender, EventArgs e)
        {
            Page.Validate();

            if (!Page.IsValid)
                return;

            UserAccountModel user = AccountManager.ValidateUser(username.Text.Trim(), pword.Text.Trim());


            if (user != null)
            {
                HttpCookie authCookie = FormsAuthentication.GetAuthCookie(user.username, false);
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);

                FormsAuthenticationTicket newTicket = new FormsAuthenticationTicket(ticket.Version
                                                                                   , ticket.Name
                                                                                   , ticket.IssueDate
                                                                                   , ticket.Expiration
                                                                                   , remChk.Checked
                                                                                   , string.Format("{0} {1}|{2}", user.firstname, user.lastname, user.role));
                authCookie.Value = FormsAuthentication.Encrypt(newTicket);

                if (remChk.Checked)
                    authCookie.Expires = ticket.Expiration;

                Response.Cookies.Add(authCookie);
                Response.Redirect("~/Control_Panel/Database_Panel.aspx", true);


            }
            else
                loginErr_msg.Visible = true;
        }
    }
}