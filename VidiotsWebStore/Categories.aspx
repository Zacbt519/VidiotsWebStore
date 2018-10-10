<%@ Page Title="" Language="C#" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="VidiotsWebStore.Categories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <br /><br />
            <h1>Categories</h1>
            <br />
            <div class="row">
                <div class="col-4">
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <br />
                    <ul class="list-group">
                        <asp:Repeater ID="rptCategories" runat="server">
                            <ItemTemplate>
                                <li class="list-group-item">
                                    <h4><%# Eval("Name") %></h4>
                                    <p><%# Eval("Description") %></p>
                                    <a href='ProductsByCategory.aspx?categoryId=<%# Eval("CategoryID") %>' class="btn btn-outline-success">View More</a>
                                    
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
</asp:Content>
