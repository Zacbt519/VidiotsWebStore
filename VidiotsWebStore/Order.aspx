<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="VidiotsWebStore.Order" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-6">
                <ul class="list-group">
                    <li class="list-group-item">
                        <br />
                        <h5>Billing Address</h5>
                        <p runat="server" id="streetAddress"> </p>
                        <p runat="server" id="cityAndProvince"></p>
                        <p runat="server" id="country"></p>
                        <p runat="server" id="postalCode"></p>
                    </li>
                </ul>
            </div>
       </div>
        <div class="row">
            <div class="col-6">
                <br />
                <asp:CheckBox ID="chkShipping" AutoPostBack="true" runat="server" Text="Shipping Address diferent from Billing Address?" OnCheckedChanged="chkShipping_CheckedChanged" />
                <br />
                <asp:Panel ID="pnlShipping" runat="server" Visible="false">
                    <div class="form-group">
                        <label>Street Address:</label>
                        <asp:TextBox ID="txtStreet" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>City:</label>
                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Province</label>
                        <asp:TextBox ID="txtProvince" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Country:</label>
                        <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    
                </asp:Panel>
            </div>
        </div>
                
        <div class="row">
            <div class="col-6">
                <asp:Button ID="btnConfirm" runat="server" Text="Confirm Address" CssClass="btn btn-success" />
            </div>
        </div>
        <div class="row">
            <div class="col-6">
                
            </div>
        </div>
    </div>
</asp:Content>

