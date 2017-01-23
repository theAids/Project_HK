<%@ Page Title="Login" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Project_HK.Accounts.Login" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title><%: Page.Title %> - Project HK</title>

    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>
    <webopt:BundleReference runat="server" Path="~/Content/css" />

</head>
<body class="login-body">
    <form runat="server">
        <asp:ScriptManager runat="server">
            <Scripts>
                <%--To learn more about bundling scripts in ScriptManager see http://go.microsoft.com/fwlink/?LinkID=301884 --%>
                <%--Framework Scripts--%>
                <asp:ScriptReference Name="jquery" />
                <asp:ScriptReference Name="bootstrap" />
                <%--Site Scripts--%>
            </Scripts>
        </asp:ScriptManager>

        <div class="container">
            <!-- Logo and project title -->
            <div class="text-center">
                <div class="logo-panel">
                    <asp:Image ID="ey_logo_hr" CssClass="logo-ey" ImageUrl="~/Content/images/EY_logo_hr.png" runat="server" />
                    <h3><b>Project HK</b></h3>
                </div>
            </div>
            <!-- / Logo and project title -->
            <div class="row">
                <div class="col-sm-8 col-md-4 col-md-offset-4 col-sm-offset-2">
                    <asp:Panel runat="server" ID="loginErr_msg" Visible="false" ForeColor="Red">Incorrect password or account does not exist.</asp:Panel>
                    <div class="form-group">
                        <asp:TextBox runat="server" ID="username" CssClass="form-control" name="username" placeholder="Username" autofocus="true" />
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="pword" class="form-control" placeholder="Password" name="password" TextMode="Password" value="" runat="server" />
                    </div>
                    <asp:Button ID="loginbtn" class="btn btn-lg btn-login btn-block" OnClick="loginbtn_Click" runat="server" Text="Login" />
                    <div class="checkbox">
                        <label><asp:CheckBox runat="server" ID="remChk" text="Remember Me"/></label>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>