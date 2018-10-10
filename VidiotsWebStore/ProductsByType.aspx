<%@ Page Title="" Language="C#" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="ProductsByType.aspx.cs" Inherits="VidiotsWebStore.ProductsByType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="list-group">
    <asp:Repeater ID="rptProducts" runat="server">
        <ItemTemplate>
            <li class="list-group-item">
                <h4><%# Eval("ProductName") %></h4>
                <asp:Image ID="productImage" CssClass="img-responsive img-thumbnail searchResultsImg" ImageUrl='<%# Eval("ImageURL") %>' Visible="true" runat="server" />
                <h6>Product ID: <span><%# Eval("ProductID") %></span></h6>
                <h6>Category: <span><%# Eval("Name") %></span></h6>
                <h6>Product Description:</h6>
                <p><%# Eval("BriefDescription") %></p>
                <br />
                <p><%# Eval("Price", "{0:c}") %></p>
                <a href='ProductFullView.aspx?productId=<%# Eval("ProductId") %>' class="btn btn-outline-success">View Product</a>
                                    
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
