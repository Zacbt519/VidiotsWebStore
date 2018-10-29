﻿<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/admin/VidiotsAdminTemplate.Master" AutoEventWireup="true" CodeBehind="ManageProduct.aspx.cs" Inherits="VidiotsWebStore.ManageProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/styles.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="container-fluid">
        <div class="row">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
        </div>
        
       
        <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-outline-danger" OnClick="btnDelete_Click" Text="Delete Product" CausesValidation="false" />
        <br /><br />
        <asp:Label ID="lblAreYouSure" runat="server" Text="Are You Sure?" Visible="false"></asp:Label>
        <asp:Button ID="btnConfirmYes" runat="server" Text="Confirm" CssClass="btn btn-outline-warning" Visible="false" OnClick="btnConfirmYes_Click" CausesValidation="false" />
        <asp:Button ID="btnConfirmNo" runat="server" Text="Cancel" CssClass="btn btn-outline-primary" Visible ="false" OnClick="btnConfirmNo_Click" CausesValidation="false" />
        <br />
        <div class="row">
            <div class="col-8">
                <asp:Image ID="productImage" ImageUrl='<%# Eval("ImageURL") %>' runat="server" AltText='<%# Eval("AltText") %>' />
                <br /><br />
                <label for="txtImageURL"><b>Image URL:</b></label>
                <asp:DropDownList ID="ddlImageURL" runat="server" CssClass="form-control">
                    <asp:ListItem Value="0" Text="---Select an Image---"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvImageURL" runat="server" ForeColor="Red" ErrorMessage="Image URL Required" ControlToValidate="ddlImageURL" Display="Dynamic">*</asp:RequiredFieldValidator>

            </div>
        </div>
        <div class="row">
            <div class="col-8">
                <div class="form-group">
                    <label for="txtProductName"><b>Product Name:</b></label>
                        <asp:TextBox ID="txtProductName" CssClass="form-control" Text='<%# Eval("ProductName") %>' runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="rfvProductName" runat="server"  ForeColor="Red" ErrorMessage="Product Name is required" ControlToValidate="txtProductName" Display="Dynamic">*Invalid</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revCatName" runat="server" ErrorMessage="Only alphanumeric character are permitted" ControlToValidate="txtProductName" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9 :-]+$">*</asp:RegularExpressionValidator>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtBriefDescription"><b>Brief Description:</b></label>
                    <asp:TextBox runat="server" ID="txtBriefDescription" CssClass="form-control" Text='<%# Eval("BriefDescription") %>' TextMode="MultiLine"></asp:TextBox><asp:RequiredFieldValidator ID="rfvBriefDescription" runat="server" ForeColor="Red" ErrorMessage="Brief Description is required" ControlToValidate="txtBriefDescription" Display="Dynamic">*Invalid</asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtFullDescription"><b>Full Description:</b></label>
                    <asp:TextBox runat="server" ID="txtFullDescription" CssClass="form-control" Text='<%# Eval("FullDescription") %>' TextMode="MultiLine"></asp:TextBox><asp:RequiredFieldValidator ID="rfvFullDescription" runat="server" ErrorMessage="Full Description is required" ForeColor="Red" ControlToValidate="txtFullDescription" Display="Dynamic">*Invalid</asp:RequiredFieldValidator>

                </div>
                <div class="form-group">
                    <label for="txtPrice"><b>Price:</b></label>
                    <asp:TextBox ID="txtPrice" CssClass="form-control" runat="server" Text='<%# Eval("Price") %>'></asp:TextBox><asp:RequiredFieldValidator ID="rfvPrice" runat="server" ForeColor="Red" ErrorMessage="Price is required" ControlToValidate="txtPrice" Display="Dynamic">*Invalid</asp:RequiredFieldValidator>

                </div>
                <div class="form-group form-check-inline">
                    <label for="chkFeatured" style="margin-right:15%;"><b>Featured:</b></label>
                    <asp:CheckBox ID="chkFeatured" runat="server" Checked='<%# Eval("Featured") %>' CssClass="form-check-input" />
                </div>
                <div class="form-group">
                    <label for="ddlProductStatus"><b>Product Status:</b></label>
                     <asp:DropDownList ID="ddlProductStatus" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0" Text="---Select a Product Status---"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvProductStatus" runat="server" ForeColor="Red" ErrorMessage="Product Status is required" ControlToValidate="ddlProductStatus" Display="Dynamic">*Invalid</asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label for="ddlCategoryID"><b>Category ID:</b></label>
                    <asp:DropDownList ID="ddlCategoryID" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0" Text="---Select a Category ID---"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ForeColor="Red" ErrorMessage="Category is required" ControlToValidate="ddlCategoryID" Display="Dynamic">*Invalid</asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label for="ddlProductType"><b>Product Type:</b></label>
                    <asp:DropDownList ID="ddlProductType" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0" Text="---Select an Product Type---"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvProductType" runat="server" ForeColor="Red" ErrorMessage="Product Type is required" ControlToValidate="ddlProductType" Display="Dynamic">*Invalid</asp:RequiredFieldValidator>
                </div>
                <br />
                    <asp:Button ID="btnUpdate" CssClass="btn btn-outline-success" runat="server" Text="Save Changes" OnClick="btnUpdate_Click"></asp:Button>

            </div>
            <div class="col-4">
                
            </div>
        </div>
    </div>
</asp:Content>
