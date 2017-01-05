<%@ Page Title="User Admin" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="UserAdmin.aspx.cs" Inherits="Project_HK.Control_Panel.UserAdmin" %>

<asp:Content runat="server" ID="User_Admin_Content" ContentPlaceHolderID="Master_Page">

    <!-- Side Bar -->
    <div class="col-sm-3 col-md-2 sidebar">
        <ul class="nav navbar-inverse nav-sidebar">
            <li><a href="#"><span class="glyphicon glyphicon-folder-close icon"></span>Database<span class="sr-only">(current)</span></a></li>
            <li><a href="#"><span class="glyphicon glyphicon-signal icon"></span>Tableau</a></li>
            <li class="active"><a href="#"><span class="glyphicon glyphicon-user icon"></span>User Admin</a></li>
        </ul>
    </div>
    <!-- / Side Bar -->
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        <h1 class="page-header">Users</h1>
        <a class="btn btn-md btn-primary addBtn" data-toggle="modal" data-target="#newUserModal" href="#"><span class="glyphicon glyphicon-plus-sign icon"></span>Add User</a>
    </div>

    <!-- Add User Modal --->
    <div class="modal fade" id="newUserModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">New User</h4>
                </div>
                <div class="modal-body form-horizontal">
                    <div class="form-group required">
                        <label class="control-label col-sm-3" for="uname">Username</label>
                        <div class="col-sm-9">
                            <asp:TextBox runat="server" CssClass="form-control" ID="uname" placeholder="Enter username" autofocus="true"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group required">
                        <label class="control-label col-sm-3" for="fname">Firstname</label>
                        <div class="col-sm-9">
                            <asp:TextBox runat="server" CssClass="form-control" ID="fname" placeholder="Enter firstname"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group required">
                        <label class="control-label col-sm-3" for="lname">Lastname</label>
                        <div class="col-sm-9">
                            <asp:TextBox runat="server" CssClass="form-control" ID="lname" placeholder="Enter lastname"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group required">
                        <label class="control-label col-sm-3" for="pword">Password</label>
                        <div class="col-sm-9">
                            <asp:TextBox runat="server" CssClass="form-control" ID="pword" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group required">
                        <label class="control-label col-sm-3" for="rpword">Confirm Password</label>
                        <div class="col-sm-9">
                            <asp:TextBox runat="server" CssClass="form-control" ID="conpword" TextMode="Password" placeholder="Re-enter password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group required">
                        <label class="control-label col-sm-3" for="role">Role</label>
                        <div class="col-sm-9">
                            <asp:DropDownList ID="role"
                                AutoPostBack="True"
                                runat="server" CssClass="form-control">

                                <asp:ListItem Selected="True" Value="user"> User </asp:ListItem>
                                <asp:ListItem Value="admin"> Administrator </asp:ListItem>

                            </asp:DropDownList>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-cancel" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary btn-proceed">Add User</button>
                </div>

            </div>
        </div>
    </div>
    <!-- / Add User Modal -->

</asp:Content>
