<%@ Page Title="Edit Profile" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Edit_Profile.aspx.cs" Inherits="Project_HK.Control_Panel.Edit_Profile" %>

<asp:Content ID="Edit_Profile_Content" ContentPlaceHolderID="Master_Page" runat="server">
    <!-- Side Bar -->
    <div class="col-sm-3 col-md-2 sidebar">
        <ul class="nav navbar-inverse nav-sidebar">
            <li><a href="Database_Panel.aspx"><span class="glyphicon glyphicon-folder-close icon"></span>Database<span class="sr-only">(current)</span></a></li>
            <li><a href="#"><span class="glyphicon glyphicon-signal icon"></span>Tableau</a></li>
            <asp:PlaceHolder runat="server" ID="adminMenu" />
        </ul>
    </div>
    <!-- / Side Bar -->

    <div class="col-sm-10 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        <h1 class="page-header">Edit Profile</h1>
        <div class="row">
            <div class="col-sm-7 col-md-8">
                <asp:UpdatePanel runat="server" ID="editUser_status_UPanel" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="editUser_status_UPanel" DynamicLayout="true">
                            <ProgressTemplate>
                                <div class="alert alert-info user-status">Updating user info...</div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                        <asp:Panel runat="server" ID="userEdit_status_panel" Visible="false">
                            <asp:Label runat="server" ID="userEdit_status_icon"></asp:Label>
                            <asp:Literal runat="server" ID="userEdit_status_lit" />
                        </asp:Panel>
                        <div class="modal-body form-horizontal">
                            <!-- username label -->
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="username">Username</label>
                                <label class="col-sm-10 username_edit" id="username">
                                    <asp:Label runat="server" ID="username_label"></asp:Label></label>
                                <asp:HiddenField ID="hidden" runat="server" />
                            </div>
                            <!-- / usermame label -->
                            <!-- fname field -->
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation_edit" ControlToValidate="fname_edit" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="fname_edit">Firstname</label>
                                <div class="col-sm-10">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="fname_edit" placeholder="Enter firstname" EnableViewState="false"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / fname field -->
                            <!-- lname field -->
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="userValidation_edit" ControlToValidate="lname_edit" ErrorMessage="This field is required." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" />
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="lname_edit">Lastname</label>
                                <div class="col-sm-10">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="lname_edit" placeholder="Enter lastname" EnableViewState="false"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / lname field -->
                            <!-- Change password panel -->
                            <div class="panel panel-default">
                                <div class="panel-heading">Change Password</div>
                                <div class="panel-body">

                                    <!-- old password -->
                                    <asp:CustomValidator runat="server" ID="oldpass" ValidationGroup="userValidation_edit" ControlToValidate="oldpasswd_edit" ErrorMessage="Password is incorrect." ForeColor="Red" Font-Italic="true" Display="Dynamic" CssClass="col-sm-offset-3" OnServerValidate="Validate_Password" />                     
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="oldpasswd_edit">Old Password</label>
                                        <div class="col-sm-9">
                                            <asp:TextBox runat="server" CssClass="form-control" ID="oldpasswd_edit" TextMode="Password" placeholder="Enter password" EnableViewState="false"></asp:TextBox>
                                        </div>
                                    </div>
                                    <!-- / old password -->
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
                            <div class="col-sm-12 text-center">
                                <asp:Button runat="server" ID="edit_btn" Text="Update Information" CssClass="btn btn-primary btn-md" ValidationGroup="userValidation_edit" OnClick="Update_Info"/>
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="edit_btn" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
