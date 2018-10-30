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
                        <br />
                        <asp:CheckBox ID="chkShipping" AutoPostBack="true" runat="server" Text="Shipping Address diferent from Billing Address?" OnCheckedChanged="chkShipping_CheckedChanged" />
                        <br /><br />
                        <asp:Panel ID="pnlShipping" runat="server" Visible="false">
                            <h5>Shipping Address:</h5>
                            <br />
                            <div class="form-group">
                                <label>Street Address:</label>
                                <asp:TextBox ID="txtStreet" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvStreet" runat="server" ErrorMessage="Street Address is required" ControlToValidate="txtStreet">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>City:</label>
                                <asp:TextBox ID="txtCity" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCity" runat="server" ErrorMessage="City is required" ControlToValidate="txtCity">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Province</label>
                                <asp:TextBox ID="txtProvince" runat="server" MaxLength="2" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvProvince" runat="server" ErrorMessage="Province is required" ControlToValidate="txtProvince">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Country:</label>
                                <asp:TextBox ID="txtCountry" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCountry" runat="server" ErrorMessage="Country is required" ControlToValidate="txtCountry">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Postal Code:</label>
                                <asp:TextBox ID="txtPostal" runat="server" MaxLength="6" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPostal" runat="server" ErrorMessage="Postal Code/Zip is required" ControlToValidate="txtPostal">*</asp:RequiredFieldValidator>
                            </div>
                        </asp:Panel>
                    </li>
                </ul>
            </div>
            
            <div class="col-6">
                 <ul class="list-group">
                    <li class="list-group-item">
                        <h3>Payment Details</h3>
                        <br />
                        <asp:RadioButton ID="rdoCredit" runat="server" GroupName="choice" OnCheckedChanged="rdoCredit_CheckedChanged" AutoPostBack="true"/> Credit Card
                        <br />
                        <asp:RadioButton ID="rdoPaypal" runat="server" GroupName="choice" OnCheckedChanged="rdoPaypal_CheckedChanged" AutoPostBack="true" Checked="true" /> Paypal
                        <br />
                        <asp:Panel ID="pnlCredit" runat="server" Visible="false">
                            <label>Credit Card Number:</label>
                            <asp:TextBox ID="txtCardNum" runat="server" CssClass="form-control" MaxLength="16"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCardNum" runat="server" ErrorMessage="Card Number is required" ControlToValidate="txtCardNum">*</asp:RequiredFieldValidator>
                            <br />
                            <label>Expiration:</label>
                            <asp:TextBox ID="txtExp" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvExpiration" runat="server" ErrorMessage="Expiration is required" ControlToValidate="txtExp">*</asp:RequiredFieldValidator>
                            <br />
                            <label>Security Code:</label>
                            <asp:TextBox ID="txtCode" runat="server" CssClass="form-control" MaxLength="3"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCode" runat="server" ErrorMessage="Security Code is required" ControlToValidate="txtCode">*</asp:RequiredFieldValidator>
                        </asp:Panel>
                    </li>
                </ul>
            </div>
       </div>    
        <div class="row">
            <div class="col-6">
                <br />
                <asp:Button ID="btnConfirm" runat="server" Text="Confirm Order" CssClass="btn btn-success" OnClick="btnConfirm_Click" />
                <br />
            </div>
        </div>
    </div>
</asp:Content>

