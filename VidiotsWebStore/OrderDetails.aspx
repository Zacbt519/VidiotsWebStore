<%@ Page Title="" Language="C#" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="VidiotsWebStore.OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-10">
                <asp:GridView ID="grvCart" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="ProductID" HeaderText="Product ID" ReadOnly="True" />
            <asp:BoundField DataField="ProductName" HeaderText="Product Name" ReadOnly="True" />
            <asp:TemplateField HeaderText="Quantity">
                <ItemTemplate>
                    <asp:TextBox ID="Quantity" runat="server" Text='<%# Eval("Quantity") %>' ReadOnly="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:c}" ReadOnly="True" />
            <asp:BoundField DataField="ItemSubtotal" DataFormatString="{0:c}" HeaderText="Item Subtotal" ReadOnly="True" />
        </Columns>

    </asp:GridView>
    <br />
    <asp:Label ID="lblOrderSubtotal" runat="server" Text="Subtotal: "></asp:Label>
    <br />
    <asp:Label ID="lblShippingCost" runat="server" Text="Shipping Cost: "></asp:Label>
    <br />
    <asp:Label ID="lblTax" runat="server" Text="Tax: "></asp:Label>
    <br />
    <asp:Label ID="lblOrderTotal" runat="server" Text="Order Total: "></asp:Label>
    <br />
    <br />
    <asp:Panel ID="pnlShipping" runat="server">
        <h5>Shipping Address:</h5>
        <br />
        <div class="form-group">
            <label>Street Address:</label>
            <asp:TextBox ID="txtStreet" runat="server" MaxLength="50" CssClass="form-control" ReadOnly="true" Text='<%# Eval("Street") %>'></asp:TextBox>

        </div>
        <div class="form-group">
            <label>City:</label>
            <asp:TextBox ID="txtCity" runat="server" MaxLength="50" CssClass="form-control" ReadOnly="true" Text='<%# Eval("City") %>'></asp:TextBox>

        </div>
        <div class="form-group">
            <label>Province</label>
            <asp:TextBox ID="txtProvince" runat="server" MaxLength="2" CssClass="form-control" ReadOnly="true" Text='<%# Eval("Province") %>'></asp:TextBox>

        </div>
        <div class="form-group">
            <label>Country:</label>
            <asp:TextBox ID="txtCountry" runat="server" MaxLength="50" CssClass="form-control" ReadOnly="true" Text='<%# Eval("Country") %>'></asp:TextBox>

        </div>
        <div class="form-group">
            <label>Postal Code:</label>
            <asp:TextBox ID="txtPostal" runat="server" MaxLength="6" CssClass="form-control" ReadOnly="true" Text='<%# Eval("PostalCode") %>'></asp:TextBox>

        </div>
    </asp:Panel>
            </div>
        </div>
    </div>

    
</asp:Content>
