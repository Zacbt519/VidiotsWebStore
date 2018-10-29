<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/admin/VidiotsAdminTemplate.Master" AutoEventWireup="true" CodeBehind="ManageCategory.aspx.cs" Inherits="VidiotsWebStore.ManageCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            <div class="col-8">
                <div class="form-group">
                    <label for="txtCatName">Category Name:</label>
                    <asp:TextBox ID="txtCatName" runat="server" CssClass="form-control" Text='<%# Eval("Name") %>'></asp:TextBox><asp:RequiredFieldValidator ID="rfvCatName" runat="server" ErrorMessage="Category Name is required" ControlToValidate="txtCatName" Display="Dynamic">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="revCatName" runat="server" ErrorMessage="Only alphanumeric character are permitted" ControlToValidate="txtCatName" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9 :-]+$">*</asp:RegularExpressionValidator>
                </div>
                <div class="form-group">
                    <label for="txtCatDesc">Description:</label>
                    <asp:TextBox ID="txtCatDesc" runat="server" CssClass="form-control" TextMode="MultiLine" Text='<%# Eval("Description") %>'></asp:TextBox><asp:RequiredFieldValidator ID="rfvCatDesc" runat="server" ErrorMessage="Category Description is required" ControlToValidate="txtCatDesc" Display="Dynamic">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Only alphanumeric character are permitted" ControlToValidate="txtCatDesc" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9 :-]+$">*</asp:RegularExpressionValidator>
                </div>
                    <asp:Button ID="btnUpdate" CssClass="btn btn-outline-success" runat="server" Text="Save Changes" OnClick="btnUpdate_Click"></asp:Button>
            </div>
        </div>
    </div>
</asp:Content>
