﻿<%@ Page Title="" Language="C#" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="ShoppingCart.aspx.cs" Inherits="VidiotsWebStore.ShoppingCart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-8">
                <h1> My Cart</h1>
                <h6><%= DateTime.Now.ToLongDateString() %></h6>
                <br />
                <asp:GridView ID="grvCart" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="ProductID" HeaderText="Product ID" ReadOnly="True" />
                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" ReadOnly="True" />
                        <asp:TemplateField HeaderText="Quantiy">
                            <ItemTemplate>
                                <asp:TextBox ID="Quantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Price" HeaderText="Price" />
                        <asp:TemplateField HeaderText="Remove From Cart">
                            <ItemTemplate>
                                <asp:CheckBox ID="Remove" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    
                </asp:GridView>
                <asp:Label ID="lblSubtotal" runat="server" Text="Subtotal"></asp:Label>
                <br /><br />

                <div class="form-inline">
                    <asp:Button ID="btnCheckout" runat="server" CssClass="btn btn-primary" Text="Check Out" OnClick="btnCheckout_Click" />
                    <a href="index.aspx" class="btn btn-primary" style="margin-left:1%; margin-right:1%;">Add Items to Cart</a>
                    <asp:Button ID="btnUpdateCart" runat="server" CssClass="btn btn-primary" Text="Update Cart" OnClick="btnUpdateCart_Click" />
                </div>

            </div>
        </div>
    </div>
</asp:Content>
