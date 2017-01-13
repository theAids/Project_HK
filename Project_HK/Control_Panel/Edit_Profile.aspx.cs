using Project_HK.Models.DbManager;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_HK.Control_Panel
{
    public partial class Edit_Profile : System.Web.UI.Page
    {
        private string username;
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
                username = ticket.Name;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                username_label.Text = username;
                fname_edit.Text = user.Split(' ')[0];
                lname_edit.Text = user.Split(' ')[1];
            }

            //check if admin
            if (role.Equals("Administrator"))
                adminMenu.Controls.Add(new LiteralControl("<li><a href='../Admin/UserAdmin.aspx'><span class='glyphicon glyphicon-user icon'></span>User Admin</a></li>"));
        }

        protected void Update_Info(object sender, EventArgs e)
        {
            userEdit_status_panel.Visible = false;

            if (Page.IsValid)
            {
                if (AccountManager.EditUser(username, HttpUtility.HtmlEncode(fname_edit.Text.Trim()), HttpUtility.HtmlEncode(lname_edit.Text.Trim()), HttpUtility.HtmlEncode(pword1_edit.Text.Trim()), role))
                {
                    userEdit_status_panel.CssClass = "alert alert-success user-status";
                    userEdit_status_icon.CssClass = "glyphicon glyphicon-ok-circle";
                    userEdit_status_lit.Text = "Your information has been updated!";
                }
                else
                {
                    userEdit_status_panel.CssClass = "alert alert-danger user-status";
                    userEdit_status_icon.CssClass = "glyphicon glyphicon-remove-circle";
                    userEdit_status_lit.Text = "Update failed!";
                }

                userEdit_status_panel.Visible = true;

            }

        }

        protected void Validate_Password(object sender, ServerValidateEventArgs e)
        {
            string curPass = AccountManager.GetPassword(username);
            string salt = AccountManager.GetUserSalt(username);
            string oldPass = AccountManager.HashPassword(HttpUtility.HtmlEncode(oldpasswd_edit.Text.Trim()), salt);

            if (oldPass.Equals(curPass))
                e.IsValid = true;
            else
                e.IsValid = false;
        }
    }
}