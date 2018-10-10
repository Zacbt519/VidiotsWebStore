﻿<%@ Page Title="" Language="C#" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="ProductFullView.aspx.cs" Inherits="VidiotsWebStore.ProductFullView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm">
                <br /><br />
                <asp:Image ID="imgProduct" CssClass="img-responsive img-thumbnail searchResultsImg" runat="server" ImageUrl='<%# Eval("ImageURL") %>' AlternateText='<%# Eval("AltText") %>' />
            </div>
        </div>
        <div class="row">
            <div class="col-8">
                <h2 runat="server" id="productName"></h2>
                <br />
                <h4>Product Description:</h4>
                <p runat="server" id="productDescription"></p>
                <br />
                <h4>Price:</h4><p runat="server" id="price"></p>
                <button class="btn btn-outline-success">Add to Cart</button>
            </div>
        </div>
    </div>
</asp:Content>
