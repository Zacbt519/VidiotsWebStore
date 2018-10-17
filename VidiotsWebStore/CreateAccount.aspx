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
                    <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ErrorMessage="First Name is a required Field" ControlToValidate="txtFirstName">*</asp:RequiredFieldValidator>
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
                    <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ErrorMessage="Last Name is a required field" ControlToValidate="txtLastName">*</asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtUserName">User Name:</label>
                    <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ErrorMessage="User Name is a required field" ControlToValidate="txtUserName">*</asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtPassword">Password:</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is a required field" ControlToValidate="txtPassword">*</asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtConfirmPassword">Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfirm" runat="server" ErrorMessage="Confirm Password is a required field" ControlToValidate="txtConfirmPassword">*</asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtDOB">Date of Birth:</label>
                    <asp:TextBox ID="txtDOB" runat="server" Text="DD/MM/YYYY" CssClass="form-control" TextMode="DateTime"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ErrorMessage="Date of Birth is a required field" ControlToValidate="txtDOB">*</asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtAddress">Street Address:</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Street Address is a required field" ControlToValidate="txtAddress">*</asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtCity">City:</label>
                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCity" runat="server" ErrorMessage="City is a required field" ControlToValidate="txtCity">*</asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtProvince">Province/State</label>
                    <asp:TextBox ID="txtProvince" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvProvince" runat="server" ErrorMessage="Province/State is a required field" ControlToValidate="txtProvince">*</asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtPostalCode">Zip/Postal Code:</label>
                    <asp:TextBox ID="txtPostalCode" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPostalCode" runat="server" ErrorMessage="Zip/Postal code is a required field" ControlToValidate="txtPostalCode">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPostal" runat="server" ErrorMessage="Zip/Postal code not in correct format" ControlToValidate="txtPostalCode">*</asp:RegularExpressionValidator>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtCountry">Country:</label>
                    <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCountry" runat="server" ErrorMessage="Country is required" ControlToValidate="txtCountry">*</asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="form-group">
                    <label for="txtPhoneNumber">Phone Number:</label>
                    <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ErrorMessage="Phone Number is a required field" ControlToValidate="txtPhoneNumber">*</asp:RequiredFieldValidator>

                </div>
                <br />
                <div class="form-group">
                    <label for="txtEmail">Email Address:</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email is a required field" ControlToValidate="txtEmail">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="Email not formatted correctly" ControlToValidate="txtEmail">*</asp:RegularExpressionValidator>
                </div>
                <br /><br />
                <div class="form-inline">
                    <asp:Button ID="btnUpdate" runat="server" Text="Update Account" CssClass="btn btn-outline-success" OnClick="btnSubmit_Click" /><button type="reset" class="btn btn-outline-warning" runat="server" id="btnReset" style="margin-left: 1%;">Clear Form</button>
                </div>
                
            </div>
        </div>
    </div>
</asp:Content>
