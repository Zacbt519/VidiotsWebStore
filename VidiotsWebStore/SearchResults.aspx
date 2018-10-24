<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="SearchResults.aspx.cs" Inherits="VidiotsWebStore.SearchResults" %>

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
                                    <a class="btn btn-outline-success" href="ProductFullView.aspx?productId=<%# Eval("ProductID") %>">View More</a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
