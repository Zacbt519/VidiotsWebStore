<%@ Page Title="" Language="C#" MasterPageFile="~/admin/VidiotsAdminTemplate.Master" AutoEventWireup="true" CodeBehind="VerifyImages.aspx.cs" Inherits="VidiotsWebStore.admin.VerifyImages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:DropDownList ID="ddlImageName" runat="server" CssClass="form-control" AppendDataBoundItems="True" OnSelectedIndexChanged="ddlImageName_SelectedIndexChanged1" AutoPostBack="true">
        <asp:ListItem Value="0" Text="---Select an Image---"></asp:ListItem>
    </asp:DropDownList>
    <div class="input-group">
        <label for="txtName">Filename: </label>
        <br />
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
    </div>
    <div class="input-group">
        <label for="txtAlt">Alternate Text: </label>
        <br />
        <asp:TextBox ID="txtAlt" runat="server" CssClass="form-control"></asp:TextBox>
    </div>
    <br />
    <asp:Button ID="btnVerify" runat="server" Text="Verify Image" OnClick="btnVerify_Click"/>
    <br />
    <asp:Image ID="img" runat="server" CssClass="img-fluid" />
</asp:Content>
