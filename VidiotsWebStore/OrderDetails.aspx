<%@ Page Title="" Language="C#" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="VidiotsWebStore.OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblDate" runat="server" Text=""
    <asp:GridView ID="grvCart" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="ProductID" HeaderText="Product ID" ReadOnly="True" />
            <asp:BoundField DataField="ProductName" HeaderText="Product Name" ReadOnly="True" />
            <asp:TemplateField HeaderText="Quantity">
                <ItemTemplate>
                    <asp:TextBox ID="Quantity" runat="server" TextMode="Number" Text='<%# Eval("Quantity") %>'></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:c}" />
            <asp:BoundField DataField="ItemSubtotal" DataFormatString="{0:c}" HeaderText="Item Subtotal" />
            <asp:TemplateField HeaderText="Remove From Cart">
                <ItemTemplate>
                    <asp:CheckBox ID="Remove" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
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
</asp:Content>
