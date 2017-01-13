using Project_HK.Models.DbManager;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_HK.Admin
{
    public partial class UserAdmin : System.Web.UI.Page
    {
        private string user;
        private string username;
        private string role;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
            {
                Response.Redirect("~/Accounts/Login.aspx", true);
            }
            // get cookies
            FormsIdentity id = HttpContext.Current.User.Identity as FormsIdentity;
            FormsAuthenticationTicket ticket = id.Ticket;

            // access logged in name Literal in Master page
            Literal currentUser = this.Master.FindControl("currentUser") as Literal;
            user = currentUser.Text = ticket.UserData.Split('|')[0];
            role = ticket.UserData.Split('|')[1];
            username = ticket.Name;

            if(!role.Equals("Administrator"))
                Response.Redirect("~/Control_Panel/Database_Panel.aspx", true);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                current_user.Value = username;

                this.userList.DataSource = AccountManager.GetAllUsers();
                this.userList.DataBind();

            }

        }

        protected void Add_User(object sender, EventArgs e)
        {
            unameVal.Validate();

            if (Page.IsValid)
            {
                string role = "";

                switch (roleList.SelectedItem.Value)
                {
                    case "1": role = "Administrator"; break;
                    case "2": role = "User"; break;
                }

                if (AccountManager.AddUser(HttpUtility.HtmlEncode(uname.Text.Trim()), HttpUtility.HtmlEncode(fname.Text.Trim()), HttpUtility.HtmlEncode(lname.Text.Trim()), HttpUtility.HtmlEncode(pword1.Text.Trim()), role))
                {
                    userAdd_status_panel.CssClass = "alert alert-success user-status";
                    userAdd_status_icon.CssClass = "glyphicon glyphicon-ok-circle";
                    userAdd_status_lit.Text = "User successfully added!";

                    this.userList.DataSource = AccountManager.GetAllUsers();
                    this.userList.DataBind();
                    userTableUpdate.Update();

                }
                else
                {
                    userAdd_status_panel.CssClass = "alert alert-danger user-status";
                    userAdd_status_icon.CssClass = "glyphicon glyphicon-remove-circle";
                    userAdd_status_lit.Text = "Adding user failed!";
                }

                userAdd_status_panel.Visible = true;

            }
        }



        protected void User_Exists(object sender, ServerValidateEventArgs e)
        {
            if (AccountManager.GetUsername(uname.Text.Trim()) == null)
                e.IsValid = true;
            else
                e.IsValid = false;
        }

        protected void Remove_User(object sender, CommandEventArgs e)
        {
            AccountManager.RemoveUser(Convert.ToInt64(e.CommandArgument));
            this.userList.DataSource = AccountManager.GetAllUsers();
            this.userList.DataBind();
            userTableUpdate.Update();
        }

        protected void Edit_User(object sender, CommandEventArgs e)
        {
            if (Page.IsValid)
            {
                string role = "";

                switch (roleList_edit.SelectedItem.Value)
                {
                    case "1": role = "Administrator"; break;
                    case "2": role = "User"; break;
                }

                string username = HttpUtility.HtmlEncode(hidden.Value.ToString());

                if (AccountManager.EditUser(username, HttpUtility.HtmlAttributeEncode(fname_edit.Text.Trim()), HttpUtility.HtmlEncode(lname_edit.Text.Trim()), HttpUtility.HtmlEncode(pword1_edit.Text.Trim()), role))
                {
                    userEdit_status_panel.CssClass = "alert alert-success user-status";
                    userEdit_status_icon.CssClass = "glyphicon glyphicon-ok-circle";
                    userEdit_status_lit.Text = "User info updated!";

                    this.userList.DataSource = AccountManager.GetAllUsers();
                    this.userList.DataBind();
                    userTableUpdate.Update();
                }
                else
                {
                    userEdit_status_panel.CssClass = "alert alert-danger user-status";
                    userEdit_status_icon.CssClass = "glyphicon glyphicon-remove-circle";
                    userEdit_status_lit.Text = "Update failed!";
                }

                username_label.Text = hidden.Value;
                userEdit_status_panel.Visible = true;

            }
        }

        /*
        protected void uname_TextChanged(object sender, EventArgs e)
        {
            unameVal.Validate();
        }
        */
    }
}