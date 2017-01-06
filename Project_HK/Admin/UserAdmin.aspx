<%@ Page Title="User Admin" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="UserAdmin.aspx.cs" Inherits="Project_HK.Admin.UserAdmin" %>

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
                <asp:UpdatePanel runat="server" ID="addUser_status_uPanel">
                    <ContentTemplate>
                        <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="addUser_status_UPanel" DynamicLayout="true">
                            <ProgressTemplate>
                                <div class="alert alert-info user-status">Adding User...</div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                        <asp:Panel runat="server" ID="userAdd_status_panel" Visible="false">
                            <asp:Label runat="server" ID="userAdd_status_icon">
                            </asp:Label>
                            <asp:Literal runat="server" ID="userAdd_status_lit" />
                        </asp:Panel>
                        <div class="modal-body form-horizontal">
                            <!-- username field -->
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation" ControlToValidate="uname" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
                            <asp:CustomValidator runat="server" ID="unameVal" ValidationGroup="uservalidation" ControlToValidate="uname" ErrorMessage="Username already exists." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" OnServerValidate="User_Exists"/>
                            <div class="form-group required">
                                <label class="control-label col-sm-3" for="uname">Username</label>
                                <div class="col-sm-9">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="uname" placeholder="Enter username" autofocus="true" AutoPostBack="true" OnTextChanged="uname_TextChanged"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / username field -->
                            <!-- fname field -->
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation" ControlToValidate="fname" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
                            <div class="form-group required">
                                <label class="control-label col-sm-3" for="fname">Firstname</label>
                                <div class="col-sm-9">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="fname" placeholder="Enter firstname"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / fname field -->
                            <!-- lname field -->
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation" ControlToValidate="lname" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
                            <div class="form-group required">
                                <label class="control-label col-sm-3" for="lname">Lastname</label>
                                <div class="col-sm-9">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="lname" placeholder="Enter lastname"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / lname field -->
                            <!-- password field -->
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation" ControlToValidate="pword1" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
                            <div class="form-group required">
                                <label class="control-label col-sm-3" for="pword1">Password</label>
                                <div class="col-sm-9">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="pword1" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / password field -->
                            <!-- confirm password field -->
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation" ControlToValidate="pword2" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
                            <asp:CompareValidator runat="server" ValidationGroup="userValidation" ControlToValidate="pword2" ControlToCompare="pword1" ErrorMessage="Entered password does not match." ForeColor="Red" Font-Italic="true" CssClass="col-sm-offset-3" />
                            <div class="form-group required">
                                <label class="control-label col-sm-3" for="pword2">Confirm Password</label>
                                <div class="col-sm-9">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="pword2" TextMode="Password" placeholder="Re-enter password"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / confirm password field -->
                            <!-- role select field -->
                            <div class="form-group required">
                                <label class="control-label col-sm-3" for="role">Role</label>
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="roleList"
                                        AutoPostBack="false"
                                        runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="True" Value="2"> User </asp:ListItem>
                                        <asp:ListItem Value="1"> Administrator </asp:ListItem>

                                    </asp:DropDownList>
                                </div>
                            </div>
                            <!-- / role select field -->
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="addUser_btn" />
                    </Triggers>
                </asp:UpdatePanel>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-cancel" data-dismiss="modal">Close</button>
                    <asp:Button runat="server" class="btn btn-primary btn-proceed" ID="addUser_btn" OnClick="Add_User" Text="Add User" ValidationGroup="userValidation" />
                </div>

            </div>
        </div>
    </div>
    <!-- / Add User Modal -->

</asp:Content>
