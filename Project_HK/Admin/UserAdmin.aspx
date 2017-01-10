<%@ Page Title="User Admin" Language="C#" AutoEventWireup="True" MasterPageFile="~/Site.Master" CodeBehind="UserAdmin.aspx.cs" Inherits="Project_HK.Admin.UserAdmin" %>

<asp:Content runat="server" ID="User_Admin_Content" ContentPlaceHolderID="Master_Page">
    <asp:HiddenField runat="server" ID="current_user" Visible="false"/> 

    <!-- Side Bar -->
    <div class="col-sm-3 col-md-2 sidebar">
        <ul class="nav navbar-inverse nav-sidebar">
            <li><a href="../Control_Panel/Database_Panel.aspx"><span class="glyphicon glyphicon-folder-close icon"></span>Database<span class="sr-only">(current)</span></a></li>
            <li><a href="#"><span class="glyphicon glyphicon-signal icon"></span>Tableau</a></li>
            <li class="active"><a href="UserAdmin.aspx"><span class="glyphicon glyphicon-user icon"></span>User Admin</a></li>
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
                                        <td class="username"><%# Eval("username") %></td>
                                        <td class="fname"><%# Eval("firstname") %></td>
                                        <td class="lname"><%# Eval("lastname") %></td>
                                        <td class="role"><%# Eval("role")%></td>
                                        <td><a data-toggle="modal" data-target="#editUserModal" class="editUser_btn" href="#"><span class="glyphicon glyphicon-pencil"></a></td>
                                        <td><asp:LinkButton runat="server" OnCommand="Remove_User" CommandArgument='<%# Eval("userID")%>'><span class='glyphicon glyphicon-trash alert-danger delBtn <%# Eval("username").Equals(current_user.Value)? "disabled":"" %>'></asp:LinkButton></td>
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
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation" ControlToValidate="uname" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
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

    <!-- Edit User Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content ">
                <div class="modal-header">
                    <h4 class="modal-title">Edit User Info</h4>
                </div>

                <asp:UpdatePanel runat="server" ID="editUser_status_UPanel">
                    <ContentTemplate>
                        <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="editUser_status_UPanel" DynamicLayout="true">
                            <ProgressTemplate>
                                <div class="alert alert-info user-status">Editting user info...</div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                        <asp:Panel runat="server" ID="userEdit_status_panel" Visible="false">
                            <asp:Label runat="server" ID="userEdit_status_icon"></asp:Label>
                            <asp:Literal runat="server" ID="userEdit_status_lit" />
                        </asp:Panel>
                        <div class="modal-body form-horizontal">
                            <!-- username label -->
                            <div class="form-group">
                                <label class="control-label col-sm-3" for="fname_edit">Username</label>
                                <label class="col-sm-9 username_edit">
                                    <asp:Label runat="server" ID="username_label"></asp:Label></label>
                                <asp:HiddenField ID="hidden" runat="server" />
                            </div>
                            <!-- / usermame label -->
                            <!-- fname field -->
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation_edit" ControlToValidate="fname_edit" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
                            <div class="form-group">
                                <label class="control-label col-sm-3" for="fname_edit">Firstname</label>
                                <div class="col-sm-9">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="fname_edit" placeholder="Enter firstname" EnableViewState="false"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / fname field -->
                            <!-- lname field -->
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation_edit" ControlToValidate="lname_edit" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
                            <div class="form-group">
                                <label class="control-label col-sm-3" for="lname_edit">Lastname</label>
                                <div class="col-sm-9">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="lname_edit" placeholder="Enter lastname" EnableViewState="false"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / lname field -->
                            <!-- role select field -->
                            <div class="form-group">
                                <label class="control-label col-sm-3" for="role">Role</label>
                                <div class="col-sm-9">
                                    <asp:DropDownList runat="server" C ID="roleList_edit" AutoPostBack="false" CssClass="form-control" EnableViewState="false">
                                        <asp:ListItem Value="2"> User </asp:ListItem>
                                        <asp:ListItem Value="1"> Administrator </asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <!-- / role select field -->
                            <!-- Change password panel -->
                            <div class="panel panel-default">
                                <div class="panel-heading">Change Password</div>
                                <div class="panel-body">
                                    <!-- new password field -->
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="pword1_edit">New Password</label>
                                        <div class="col-sm-9">
                                            <asp:TextBox runat="server" CssClass="form-control" ID="pword1_edit" TextMode="Password" placeholder="Enter password" EnableViewState="false"></asp:TextBox>
                                        </div>
                                    </div>
                                    <!-- / new password field -->
                                    <!-- confirm password field -->
                                    <asp:CompareValidator runat="server" ValidationGroup="userValidation_edit" ControlToValidate="pword2_edit" ControlToCompare="pword1_edit" ErrorMessage="Entered password does not match." ForeColor="Red" Font-Italic="true" CssClass="col-sm-offset-3" />
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="pword2_edit">Confirm Password</label>
                                        <div class="col-sm-9">
                                            <asp:TextBox runat="server" CssClass="form-control" ID="pword2_edit" TextMode="Password" placeholder="Re-enter password" EnableViewState="false"></asp:TextBox>
                                        </div>
                                    </div>
                                    <!-- confirm password field -->
                                </div>
                            </div>
                            <!-- / Change password panel -->
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="editUser_btn" />
                    </Triggers>
                </asp:UpdatePanel>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-cancel" data-dismiss="modal">Close</button>
                    <asp:Button runat="server" class="btn btn-primary btn-proceed" ID="editUser_btn" OnCommand="Edit_User" Text="Update Info" ValidationGroup="userValidation_edit" />
                </div>
            </div>
        </div>
    </div>
    <!-- Edit User Modal -->
    <script type="text/javascript">

        function pageLoad() {
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

            /*Re-bind datable for asyncpost
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
            });*/

            // clear all fields for new user modal
            $('.addBtn').click(function () {

                //clear client-side validator
                for (i = 0; i < Page_Validators.length; i++) {
                    if (Page_Validators[i].validationGroup == "userValidation")
                        ValidatorEnable(Page_Validators[i], false);
                }

                // clear server-side validator
                $('#<%= unameVal.ClientID%>').hide();

                // hide add user status
                $('#<%= userAdd_status_panel.ClientID%>').hide();

                $('#newUserModal input:text').each(function () {
                    $(this).val('');
                });
            });

            // Edit function script
            $('.editUser_btn').click(function () {

                //clear validators
                for (i = 0; i < Page_Validators.length; i++) {
                    if (Page_Validators[i].validationGroup == "userValidation") {
                        ValidatorEnable(Page_Validators[i], false);
                    }
                }

                // hide edit user status
                $('#<%= userEdit_status_panel.ClientID%>').hide();

                $('#<%= username_label.ClientID%>').text(($(this).parent().siblings('.username').text()));
                $('#<%= hidden.ClientID%>').val($(this).parent().siblings('.username').text());
                $('#<%= fname_edit.ClientID%>').val($(this).parent().siblings('.fname').text());
                $('#<%= lname_edit.ClientID%>').val($(this).parent().siblings('.lname').text());

                var role;
                switch ($(this).parent().siblings('.role').text()) {
                    case 'Administrator': role = 1; break;
                    case 'User': role = 2; break;
                }

                $('#<%= roleList_edit.ClientID%>').val(role).change();

            });

            $('.delBtn').click(function () {
                if ($(this).hasClass("disabled"))
                    return false;
                else
                    return confirm("Are you sure you want to delete this user?");
            });
        }
        /*
        function UserDeleteConfirmation() {
            
        }*/
    </script>
</asp:Content>
