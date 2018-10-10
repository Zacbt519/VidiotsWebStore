<%@ Page Title="" Language="C#" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="ProductsByCategory.aspx.cs" Inherits="VidiotsWebStore.ProductsByCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <br />
        <br />
        <h1>Products</h1>
        <div class="row">
            <div class="col-12">
                <ul class="list-group">
                    <asp:Repeater id="rptProducts" runat="server">
                        <ItemTemplate>
                            <li class="list-group-item">
                                <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageURL") %>' CssClass="img-responsive img-thumbnail searchResultsImg" /> 
                                <br />
                                <h4><%# Eval("ProductName") %></h4>
                                <h6><%# Eval("ProductID") %></h6>
                                <p><%# Eval("BriefDescription") %></p>
                                <br />
                                <p><%# Eval("Price", "{0:c}") %></p>
                                <a href='ProductFullView.aspx?productId=<%# Eval("ProductID") %>' class="btn btn-outline-success">View Product</a><a href="#" class="btn btn-primary" style="margin-left:1%;">Add to Cart</a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
