<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/admin/VidiotsAdminTemplate.Master" AutoEventWireup="true" CodeBehind="CategoryAdmin.aspx.cs" Inherits="VidiotsWebStore.CategoryAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <h1>Categories</h1>
        <div class="row">
            <div class="col">
                <ul class="list-group">
                    <asp:Repeater ID="rptCategories" runat="server">
                        <ItemTemplate>
                            <li class="list-group-item">
                                <h3><%# Eval("Name") %></h3>
                                <p><%# Eval("Description") %></p>
                                <a href='ManageCategory.aspx?categoryID=<%# Eval("CategoryID") %>' class="btn btn-info">Manage Category</a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <a href="AddCategory.aspx" class="btn btn-info">Add New Category</a>
            </div>
        </div>
    </div>
</asp:Content>
