<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/admin/VidiotsAdminTemplate.Master" AutoEventWireup="true" CodeBehind="ArchiveCustomer.aspx.cs" Inherits="VidiotsWebStore.ArchiveCustomer" %>

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
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success" OnClick="btnSearch_Click" />
                    </span>
                </div>
                <br />
            </div>
        </div>
        <div class="row">
            <div class="col-8">
            </div>
        </div>
    </div>
    <asp:GridView ID="grvCustomers" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" />
            <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" />
            <asp:TemplateField HeaderText="IsArchived">
                <ItemTemplate>
                    <asp:CheckBox ID="chkArchived" runat="server" Checked='<%# Eval("IsArchived") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Button ID="btnArchive" runat="server" OnClick="btnArchive_Click" Text="Archive Customers" />
</asp:Content>
