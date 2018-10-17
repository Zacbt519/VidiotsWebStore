<%@ Page Title="" Language="C#" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="VidiotsWebStore.Order" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-6">
                <ul class="list-group">
                    <li class="list-group-item">
                        <h5>Billing Address</h5>
                        <p><%#Eval("StreetAddress") %></p>
                        <p><%#Eval("City")  %>, <%# Eval("Province") %></p>
                        <p><%#Eval("Country") %></p>
                        <p><%#Eval("PostalCode") %></p>
                    </li>
                </ul>
            </div>
        </div>
        <div class="row">
            <div class="col-6">

            </div>
        </div>
    </div>
</asp:Content>
