﻿<%@ Page Title="User Admin" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="UserAdmin.aspx.cs" Inherits="Project_HK.Admin.UserAdmin" %>

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

        <div class="row">
            <div class="col-sm-7 col-md-8">

                <ul class="list-unstyled">
                    <li><a class="btn btn-sm btn-primary addBtn" data-toggle="modal" data-target="#newUserModal" href="#"><span class="glyphicon glyphicon-plus-sign icon"></span>Add User</a></li>
                </ul>


                <!-- User Table -->
                <asp:UpdatePanel runat="server" ID="userTableUpdate" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="table-responsive">
                            <asp:Repeater runat="server" ID="userList">
                                <HeaderTemplate>
                                    <table id="usersTable" class="table table-striped table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Username</th>
                                                <th>Firstname</th>
                                                <th>Lastname</th>
                                                <th>Role</th>
                                                <th class="no-sort"></th>
                                                <th class="no-sort"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("username") %></td>
                                        <td><%# Eval("firstname") %></td>
                                        <td><%# Eval("lastname") %></td>
                                        <td><%# Convert.ToInt64(Eval("userID")) / 1000 == 1 ? "Administrator" : "User" %></td>
                                        <td><a href="#"><span class="glyphicon glyphicon-pencil"></a></td>
                                        <td><asp:LinkButton runat="server" OnCommand="Remove_User" OnClientClick="return UserDeleteConfirmation()" CommandArgument='<%# Eval("userID")%>'><span class="glyphicon glyphicon-trash alert-danger"></asp:LinkButton></td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </tbody>
                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                        <!-- User Table -->
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>
        </div>
    </div>
    <!-- Add User Modal --->
    <div class="modal fade" id="newUserModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content ">
                <div class="modal-header">
                    <h4 class="modal-title">New User</h4>
                </div>
                <asp:UpdatePanel runat="server" ID="addUser_status_UPanel">
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
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation" ControlToValidate="uname" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3"/>
                            <asp:CustomValidator runat="server" ID="unameVal" ValidationGroup="uservalidation" ControlToValidate="uname" ErrorMessage="Username already exists." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" OnServerValidate="User_Exists" />
                            <div class="form-group required">
                                <label class="control-label col-sm-3" for="uname">Username</label>
                                <div class="col-sm-9">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="uname" placeholder="Enter username" autofocus="true" EnableViewState="false"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / username field -->
                            <!-- fname field -->
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation" ControlToValidate="fname" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
                            <div class="form-group required">
                                <label class="control-label col-sm-3" for="fname">Firstname</label>
                                <div class="col-sm-9">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="fname" placeholder="Enter firstname" EnableViewState="false"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / fname field -->
                            <!-- lname field -->
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation" ControlToValidate="lname" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
                            <div class="form-group required">
                                <label class="control-label col-sm-3" for="lname">Lastname</label>
                                <div class="col-sm-9">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="lname" placeholder="Enter lastname" EnableViewState="false"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / lname field -->
                            <!-- password field -->
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation" ControlToValidate="pword1" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
                            <div class="form-group required">
                                <label class="control-label col-sm-3" for="pword1">Password</label>
                                <div class="col-sm-9">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="pword1" TextMode="Password" placeholder="Enter password" EnableViewState="false"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / password field -->
                            <!-- confirm password field -->
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation" ControlToValidate="pword2" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
                            <asp:CompareValidator runat="server" ValidationGroup="userValidation" ControlToValidate="pword2" ControlToCompare="pword1" ErrorMessage="Entered password does not match." ForeColor="Red" Font-Italic="true" CssClass="col-sm-offset-3" />
                            <div class="form-group required">
                                <label class="control-label col-sm-3" for="pword2">Confirm Password</label>
                                <div class="col-sm-9">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="pword2" TextMode="Password" placeholder="Re-enter password" EnableViewState="false"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / confirm password field -->
                            <!-- role select field -->
                            <div class="form-group required">
                                <label class="control-label col-sm-3" for="role">Role</label>
                                <div class="col-sm-9">
                                    <asp:DropDownList runat="server" C ID="roleList" AutoPostBack="false" CssClass="form-control" EnableViewState="false">
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
    <script type="text/javascript">

        //bind table at startup
        $(document).ready(function () {
            table = $('#usersTable').dataTable({
                'columnDefs': [{
                    'targets': 'no-sort',
                    'width': '20px',
                    'orderable': false
                }],
                'retrieve': true
            });
        });

        //Re-bind datable for asyncpost
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            table = $('#usersTable').dataTable({
                'columnDefs': [{
                    'targets': 'no-sort',
                    'width': '20px',
                    'orderable': false
                }],
                'retrieve': true
            });
        });

        // clear all fields for new user modal
        $('.addBtn').click(function () {
            
            //clear client-side validator
            for (i = 0; i < Page_Validators.length; i++) {
                if (Page_Validators[i].validationGroup == "userValidation") {
                    ValidatorEnable(Page_Validators[i], false);
                }
            }

            // clear server-side validator
            $('#<%= unameVal.ClientID%>').hide();

            // hide add user status
            $('#<%= userAdd_status_panel.ClientID%>').hide();

            $('#newUserModal input:text').each(function () {
                $(this).val('');
            });
        });

        function UserDeleteConfirmation() {
            return confirm("Are you sure you want to delete this user?");
        }
    </script>
</asp:Content>