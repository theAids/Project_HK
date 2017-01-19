﻿<%@ Page Title="Database" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Database_Panel.aspx.cs" Inherits="Project_HK.Control_Panel.Db_Extract" %>

<asp:Content ID="Db_Panel_Content" ContentPlaceHolderID="Master_Page" runat="server">

    <!-- Side Bar -->
    <div class="col-sm-3 col-md-2 sidebar">
        <ul class="nav navbar-inverse nav-sidebar">
            <li class="active"><a href="Database_Panel.aspx"><span class="glyphicon glyphicon-folder-close icon"></span>Database<span class="sr-only">(current)</span></a></li>
            <li><a href="#"><span class="glyphicon glyphicon-signal icon"></span>Tableau</a></li>
            <asp:PlaceHolder runat="server" ID="adminMenu" />
        </ul>
    </div>
    <!-- / Side Bar -->

    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        <h1 class="page-header">Database</h1>
        <div class="row">

            <div class="col-sm-6 col-md-7">
                <!-- database connection table -->
                <div class="panel panel-default db-panel">
                    <div class="panel-heading"><span class="glyphicon glyphicon-th-list icon"></span>Database Connections</div>
                    <div class="table-responsive">
                        <asp:Repeater ID="db_connection" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Server Name</th>
                                            <th>Database Name</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="index"><%# Eval("index") %></td>
                                    <td class="servername"><%# Eval("servername") %></td>
                                    <td class="dbname"><%# Eval("dbname") %></td>
                                    <td>
                                        <asp:LinkButton runat="server" OnCommand="extractXML" CommandArgument='<%# Eval("name")%>'>Export</asp:LinkButton></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                            </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
            <!-- / database connection table -->

            <!-- Action Log -->
            <div class="col-sm-6 col-md-5">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <span class="glyphicon glyphicon-log-in icon"></span>Export Log
                    <asp:LinkButton runat="server" ID="clearBtn" OnClick="ClearLog" OnClientClick="clear_logs()" CssClass="pull-right">Clear</asp:LinkButton>
                    </div>
                    <div class="panel-body log-panel">
                        <asp:UpdatePanel runat="server" ID="logUpdatePanel">
                            <ContentTemplate>
                                <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="logUpdatePanel" DynamicLayout="true">
                                </asp:UpdateProgress>
                                <asp:Literal runat="server" ID="logPanel" />
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="clearBtn" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>

            </div>
            <!--/ Action Log -->
        </div>

        <!----------------- Confirmation Modal -------------------->
        <div class="modal fade" id="infoModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title"><span class="glyphicon glyphicon-info-sign alert-info icon"></span>Database Extraction</h4>
                    </div>
                    <div class="modal-body">
                        <p>
                            Extraction will be made from <b class="modDb">Db Name</b> database in the <b class="modServer">Server Name</b>
                        server.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default btn-cancel" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary btn-proceed">Proceed</button>
                    </div>

                </div>
            </div>
        </div>
        <!-- / Confirmation Modal -->
    </div>

    <script type="text/javascript">
        function pageLoad() {
            $('.log-panel').removeClass('clear-log').css('opacity', '');
        }

        //clear log async progress status
        function clear_logs() {
            $('.log-panel').addClass('clear-log').css('opacity',0.5);
        }
    </script>

</asp:Content>
