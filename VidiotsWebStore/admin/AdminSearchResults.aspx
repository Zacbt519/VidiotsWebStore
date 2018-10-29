<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/admin/VidiotsAdminTemplate.Master" AutoEventWireup="true" CodeBehind="AdminSearchResults.aspx.cs" Inherits="VidiotsWebStore.AdminSearchResults" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/styles.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div class="container-fluid">
            <h1>Search Results:</h1>
            <br />
            <div class="row">
                <div class="col-4">
                    
                </div>
            </div>
            <div class="row">
                <div class="col-8">
                    <br />
                    <ul class="list-group">
                        <asp:Repeater ID="rptResults" runat="server">
                            <ItemTemplate>
                                <li class="list-group-item">
                                    <h3><%# Eval("ProductName") %></h3>
                                    <asp:Image ID="productImage" CssClass="img-responsive img-thumbnail searchResultsImg" ImageUrl='<%# Eval("ImageURL") %>' Visible="true" runat="server" />
                                    <h4>Brief Description: </h4>
                                    <p><%# Eval("BriefDescription") %></p>
                                    <h4>Price: </h4>
                                    <p><%# Eval("Price","{0:c}") %></p>
                                    <a href='ManageProduct.aspx?productId=<%# Eval("ProductID") %>' class="btn btn-outline-success">Manage Product</a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
