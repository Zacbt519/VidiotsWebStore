<%@ Page Title="" Language="C#" MasterPageFile="~/admin/VidiotsAdminTemplate.Master" AutoEventWireup="true" CodeBehind="UploadImage.aspx.cs" Inherits="VidiotsWebStore.admin.UploadImage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="input-group">
        <asp:FileUpload ID="uplPics" runat="server" CssClass="form-control"></asp:FileUpload>
    </div>
    <br />
    <div class="input-group">
        <label for="txtAlt">Alternate Text: </label>
        <br />
        <asp:TextBox ID="txtAlt" runat="server" CssClass="form-control"></asp:TextBox>
    </div>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAlt" ErrorMessage="Alternate Text is required"></asp:RequiredFieldValidator>
    <br />
    <div class="input-group">
        <label for="txtName">Filename: </label>
        <br />
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
    </div>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtName" ErrorMessage="Filename is requried"></asp:RequiredFieldValidator>
    <br />
    <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" />
    <br />
    <asp:Image ID="imgUploaded" runat="server" CssClass="img-fluid"/>
</asp:Content>
