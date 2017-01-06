using Project_HK.Models.DbManager;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_HK.Admin
{
    public partial class UserAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.userList.DataSource = AccountManager.GetAllUsers();
                this.userList.DataBind();

            }

        }

        protected void Add_User(object sender, EventArgs e)
        {
            Page.Validate();

            if(Page.IsValid)
            {
                long id = AccountManager.GetLastID(Convert.ToInt32(roleList.SelectedItem.Value));

                Debug.WriteLine(id);

                if (id == 0)
                {
                    switch (roleList.SelectedItem.Value)
                    {
                        case "1": id = 1000; break;
                        case "2": id = 2000; break;
                    }
                }

                if (AccountManager.AddUser(id + 1, HttpUtility.HtmlEncode(uname.Text.Trim()), HttpUtility.HtmlEncode(fname.Text.Trim()), HttpUtility.HtmlEncode(lname.Text.Trim()), HttpUtility.HtmlEncode(pword1.Text.Trim())))
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

        }

        /*
        protected void uname_TextChanged(object sender, EventArgs e)
        {
            unameVal.Validate();
        }
        */
    }
}