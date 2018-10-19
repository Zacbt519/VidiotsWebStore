<%@ Page Title="" Language="C#" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="ShoppingCart.aspx.cs" Inherits="VidiotsWebStore.ShoppingCart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-8">
                <h1> My Cart</h1>
                <h6><%= DateTime.Now.ToLongDateString() %></h6>
                <br />
                <ul class="list-group">
                    <asp:Repeater ID="rptCart" runat="server">
                        <ItemTemplate>
                            <li class="list-group-item">
                                <h3><%# Eval("ProductName") %></h3>
                                <asp:Image ID="imgProduct" runat="server" CssClass="img-responsive img-thumbnail searchResultsImg" ImageUrl='<%# Eval("ImageURL") %>' />
                                <p>Price: <%# Eval("Price", "{0:c}") %></p>
                                <asp:Label ID="lblQty" runat="server" Text="Quantity" ></asp:Label>
                                <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                <br />
                                
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
                <label></label>
                <asp:TextBox ID="txtTotal" runat="server" CssClass="form-control"></asp:TextBox>
                <br /><br />

                <div class="form-inline">
                    <asp:Button ID="btnCheckout" runat="server" CssClass="btn btn-primary" Text="Check Out" OnClick="btnCheckout_Click" />
                    <a href="index.aspx" class="btn btn-primary" style="margin-left:1%; margin-right:1%;">Add Items to Cart</a>
                    <asp:Button ID="btnUpdateCart" runat="server" CssClass="btn btn-primary" Text="Update Cart" />
                </div>

            </div>
        </div>
    </div>
</asp:Content>
