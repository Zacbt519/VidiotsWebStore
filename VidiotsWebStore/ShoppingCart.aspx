<%@ Page Title="" Language="C#" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="ShoppingCart.aspx.cs" Inherits="VidiotsWebStore.ShoppingCart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-8">
                <h1> My Cart</h1>
                <ul class="list-group">
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <li class="list-group-item">
                                <h3><%# Eval("ProductName") %></h3>
                                <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageURL") %>' />
                                <p><%# Eval("Price") %></p>
                                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" Text='<%# Eval("Quantity") %>'></asp:TextBox>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
                <label></label>
                <asp:TextBox ID="txtTotal" runat="server" CssClass="form-control"></asp:TextBox>
                <br /><br />
                <asp:Button ID="btnCheckout" runat="server" CssClass="btn btn-primary" Text="Check Out" />

            </div>
        </div>
    </div>
</asp:Content>
