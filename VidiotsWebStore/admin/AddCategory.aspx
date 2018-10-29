<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/admin/VidiotsAdminTemplate.Master" AutoEventWireup="true" CodeBehind="AddCategory.aspx.cs" Inherits="VidiotsWebStore.AddCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <br />
    <div class="container-fluid">
        <h3>Add a new Category</h3>
        <br />
        <br />
        <div class="row">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
        </div>
        <div class="row>"
            <div class="col-4">
                <asp:Label ID="lblCategoryName" runat="server" Text="Category Name:"></asp:Label>
                    <asp:TextBox ID="txtCategoryName" runat="server" MaxLength="15" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" ErrorMessage="Category Name is required" ControlToValidate="txtCategoryName" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revCatName" runat="server" ErrorMessage="Only alphanumeric character are permitted" ControlToValidate="txtCategoryName" Display="Dynamic" ValidationExpression="^[a-zA-Z][a-zA-Z0-9]*$">*</asp:RegularExpressionValidator>
                <br />
                <br />
                <asp:Label ID="lblCategoryDescription" runat="server" Text="Category Description: "></asp:Label>
                    <asp:TextBox ID="txtCatDesc" runat="server" MaxLength="200" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCatDesc" runat="server" ErrorMessage="Category Description is required" ControlToValidate="txtCatDesc" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Button ID="btnAddNewCategory" runat="server" Text="Add New Category" CssClass="btn btn-outline-success" OnClick="btnAddNewCategory_Click" />

            </div>
        </div>
    </div>

</asp:Content>
