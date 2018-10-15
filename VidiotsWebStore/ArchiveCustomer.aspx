<%@ Page Title="" Language="C#" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="ArchiveCustomer.aspx.cs" Inherits="VidiotsWebStore.ArchiveCustomer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-8">
                <h3>Search Customers</h3>
                <div class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>
                    &nbsp;
                    <span class="input-group-btn">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success" />
                    </span>
                </div>  
                <br />
            </div>
            <div class="row">
                <div class="col-8">
                    <ul class="list-group">
                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate>
                                <li class="list-group-item">
                                    <h3><%# Eval("CustomerName") %></h3>
                                    <asp:Button ID="btnArchive" runat="server" CssClass="btn btn-warning" Text="Archive Customer" />
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
