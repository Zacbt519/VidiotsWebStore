<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/admin/VidiotsAdminTemplate.Master" AutoEventWireup="true" CodeBehind="UpdateImage.aspx.cs" Inherits="VidiotsWebStore.admin.UpdateImage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-6">
                <h1>Update Images</h1>
                <br />
                <asp:DropDownList ID="ddlImages" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlImages_SelectedIndexChanged">
                    <asp:ListItem Value="0" Text="---Select an Image---"></asp:ListItem>
                </asp:DropDownList>
                <br />
                <asp:Image ID="imgPreview" runat="server" CssClass="img-responsive img-thumbnail searchResultsImg" />
            </div>
            <div class="col-6">
                 <h1>Image Info</h1>
                <br />
                <div class="form-group">
                    <label>File Name:</label>
                    <asp:TextBox ID="txtFileName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label>Alt Text:</label>
                    <asp:TextBox ID="txtAltText" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-12">
                <div class="form-inline">
                    <asp:Button ID="btnUpdate" runat="server" Text="Update Image Data" CssClass="btn btn-light" OnClick="btnUpdate_Click" />
                    <span style="margin-left:1%; margin-right:1%"></span>
                    <asp:Button ID="btnDelete" runat="server" Text="Delete Image" CssClass="btn btn-danger" OnClick="btnDelete_Click" />
                    <br /><br />
                </div>
                <div class="form-group" id="areYouSure" runat="server" visible="false">
                        <h5> Are you sure you wish to delete this image from the Databse?</h5>
                        <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-danger" OnClick="btnYes_Click" />
                        <span style="margin-left:1%"></span>
                        <asp:Button ID="btnNo" runat="server" Text="No"  CssClass="btn btn-success" OnClick="btnNo_Click"/>
                    </div>
            </div>
        </div>
    </div>
</asp:Content>
