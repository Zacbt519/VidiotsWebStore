<%@ Page Title="" Language="C#" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="CreateAccount.aspx.cs" Inherits="VidiotsWebStore.CreateAccount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-8">
                <h1>Create Account</h1>
                <br />

                <div class="form-group">
                    <label for="txtFirstName">First Name:</label>
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtMiddleInitial">Middle Initial:</label>
                    <asp:TextBox ID="txtMiddleInitial" runat="server" MaxLength="2" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtLastName">Last Name:</label>
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtUserName">User Name:</label>
                    <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtPassword">Password:</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtConfirmPassword">Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtDOB">Date of Birth:</label>
                    <asp:TextBox ID="txtDOB" runat="server" Text="DD/MM/YYYY" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtAddress">Street Address:</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtCity">City:</label>
                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtProvince">Province/State</label>
                    <asp:TextBox ID="txtProvince" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtPostalCode">Zip/Postal Code:</label>
                    <asp:TextBox ID="txtPostalCode" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtCountry">Country:</label>
                    <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtPhoneNumber">Phone Number:</label>
                    <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtEmail">Email Address:</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <br /><br />
                <div class="form-inline">
                    <asp:Button ID="btnSubmit" runat="server" Text="Create Account" CssClass="btn btn-outline-success" /><button type="reset" class="btn btn-outline-warning" runat="server" id="btnReset" style="margin-left: 1%;">Clear Form</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
